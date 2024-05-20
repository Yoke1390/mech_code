#include <client-side.h>
#include <my-ipc.h>
#include <public.h>
#include <redundant.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

const char myName[] = "03240236";

// copied form ex1.c
const char deployment[] =
    "Bf5f6f7f8 Cc0d0e0 Cg1g2g3 Dc8d8 Di3i2 Dh5i5 Sb3 Sb5 Sd4 Sh7 ";
enum ship { UNKNOWN, ROCK, NOSHIP, BSHIP, CSHIP, DSHIP, SSHIP, TARGET };

int cur_x = 0;
int cur_y = 0;
enum ship enemy_board[BD_SIZE][BD_SIZE]; // BD_SIZE is 9 (defined in public.h)

void respond_with_name(void) {
  char *str = (char *)malloc(sizeof(myName));
  strcpy(str, myName);
  send_to_ref(str);
  free(str);
}

void respond_with_deployment(void) {
  char *str = (char *)malloc(sizeof(deployment));
  strcpy(str, deployment);
  send_to_ref(str);
  free(str);
}

// copied from ex4.c
void init_board(void) {
  int ix, iy;

  for (ix = 0; ix < (BD_SIZE); ix++) {
    for (iy = 0; iy < (BD_SIZE); iy++) {
      enemy_board[ix][iy] = UNKNOWN;
    }
  }

  enemy_board[0][0] = ROCK;
  enemy_board[0][1] = ROCK;
  enemy_board[1][0] = ROCK;

  enemy_board[0][8] = ROCK;
  enemy_board[0][7] = ROCK;
  enemy_board[1][8] = ROCK;

  enemy_board[8][0] = ROCK;
  enemy_board[7][0] = ROCK;
  enemy_board[8][1] = ROCK;

  enemy_board[8][8] = ROCK;
  enemy_board[7][8] = ROCK;
  enemy_board[8][7] = ROCK;
}

// =====================================================================================================

// ==== set target ====

void search_target(int *x, int *y) {
  int i, j;

  for (i = 0; i < BD_SIZE; i++) {
    for (j = 0; j < BD_SIZE; j++) {
      if (enemy_board[i][j] == TARGET) {
        *x = i;
        *y = j;
        return;
      }
    }
  }

  *x = -1;
  *y = -1;
}

void sweep_edge(int *x, int *y) {
  int i;
  for (i = 2; i < BD_SIZE - 2; i++) {
    if (enemy_board[0][i] == UNKNOWN) {
      *x = 0;
      *y = i;
      return;
    }
    if (enemy_board[8][i] == UNKNOWN) {
      *x = 8;
      *y = i;
      return;
    }
    if (enemy_board[i][0] == UNKNOWN) {
      *x = i;
      *y = 0;
      return;
    }
    if (enemy_board[i][8] == UNKNOWN) {
      *x = i;
      *y = 8;
      return;
    }
  }
  // 見つからなかったときの処理
  *x = -1;
  *y = -1;
}

void sweep_spacial(int *x, int *y) {
  // B, C, Dを優先的に見つけられるように、１マス感覚でスイープ
  int i, j;
  for (i = 0; i < BD_SIZE; i++) {
    for (j = 0; j < BD_SIZE; j++) {
      if (enemy_board[i][j] == UNKNOWN && enemy_board[i][j + 1] == UNKNOWN) {
        *x = i;
        *y = j + 1;
        return;
      }
    }
  }
  *x = -1;
  *y = -1;
}

void random_xy(int *x, int *y) {
  while (true) {
    *x = rand() % BD_SIZE;
    *y = rand() % BD_SIZE;

    if (enemy_board[*x][*y] == UNKNOWN) {
      break;
    }
  }
}

// == main ==
void respond_with_shot(void) {
  // printf("\nTest of count_ship_length(%d, %d): Result = %d\n", cur_x, cur_y,
  // count_ship_length(cur_x, cur_y));

  char shot_string[MSG_LEN];
  int x, y;

  search_target(&x, &y);
  if (x < 0) {
    sweep_edge(&x, &y);
  }
  if (x < 0) {
    sweep_spacial(&x, &y);
  }
  if (x < 0) {
    random_xy(&x, &y);
  }

  printf("[%s] shooting at %d%d ... ", myName, x, y);
  sprintf(shot_string, "%d%d", x, y);
  send_to_ref(shot_string);
  cur_x = x;
  cur_y = y;
}

// ==== recording ====

// == utils ==
bool is_ship(int x, int y) {
  if (x < 0 || 8 < x || y < 0 || 8 < y)
    return false;
  enum ship value = enemy_board[x][y];
  return (value == BSHIP || value == CSHIP || value == DSHIP || value == SSHIP);
}

void record_noship(int x, int y) {
  if (0 <= x && x <= 8 && 0 <= y && y <= 8) {
    if (enemy_board[x][y] == UNKNOWN || enemy_board[x][y] == TARGET) {
      enemy_board[x][y] = NOSHIP;
    }
  }
}

// == finish ship ==
int count_ship_length(int x, int y) {
  int count = 1;

  int move_x = -1;
  while (is_ship(x + move_x, y)) {
    count++;
    move_x--;
  }
  move_x = 1;
  while (is_ship(x + move_x, y)) {
    count++;
    move_x++;
  }

  int move_y = -1;
  while (is_ship(x, y + move_y)) {
    count++;
    move_y--;
  }
  move_y = 1;
  while (is_ship(x, y + move_y)) {
    count++;
    move_y++;
  }

  return count;
}

int get_ship_length(enum ship target) {
  switch (target) {
  case UNKNOWN:
    return 0;
  case TARGET:
    return 0;
  case ROCK:
    return 0;
  case NOSHIP:
    return 0;
  case BSHIP:
    return 4;
  case CSHIP:
    return 3;
  case DSHIP:
    return 2;
  case SSHIP:
    return 1;
  default:
    return -1; // 無効な値の場合
  }
}

void finish_ship(int x, int y) {
  // 一つの船を撃沈したときに周囲をNOSHIPにする
  // 撃沈したときにその船の端を撃ったと仮定する
  // record_diagで斜めは埋められているので、両端の２点をNOSHIPにすればいい。
  enum ship ship_type = enemy_board[x][y];

  // printf("\n[DEBUG] finished %d/%d\n", count_ship_length(x, y),
  // get_ship_length(ship_type));

  if (count_ship_length(x, y) == get_ship_length(ship_type)) {
    // すべての船を撃沈したときのみ処理。
    printf("\nFinishing a ship at (%d, %d)\n", x, y);

    if (is_ship(x, y + 1)) {
      record_noship(x, y - 1);
      record_noship(x, y + get_ship_length(ship_type));
    } else if (is_ship(x, y - 1)) {
      record_noship(x, y + 1);
      record_noship(x, y - get_ship_length(ship_type));
    } else if (is_ship(x - 1, y)) {
      record_noship(x + 1, y);
      record_noship(x - get_ship_length(ship_type), y);
    } else if (is_ship(x + 1, y)) {
      record_noship(x - 1, y);
      record_noship(x + get_ship_length(ship_type), y);
    }
  }
}

// == other ==
void record_diag(int x, int y) {
  // 船があった時に斜めをNSHIPにする
  // 端の処理はrecord_noshipの内部にあるので気にしないでいい
  record_noship(x - 1, y - 1);
  record_noship(x - 1, y + 1);
  record_noship(x + 1, y - 1);
  record_noship(x + 1, y + 1);
}
void check_next(int x, int y) {
  // 隣に船がある場合に逆サイドをNOSHIPにする
  // 上に船があるときに左右をNOSHIPにするなど
  if (is_ship(x - 1, y), is_ship(x + 1, y)) {
    if (y < 8)
      record_noship(x, y + 1);
    if (y > 0)
      record_noship(x, y - 1);
  }
  if (is_ship(x, y - 1), is_ship(x, y + 1)) {
    if (x < 8)
      record_noship(x + 1, y);
    if (x > 0)
      record_noship(x - 1, y);
  }
}

void set_target(int x, int y) {
  if (x > 0 && enemy_board[x - 1][y] == UNKNOWN) {
    enemy_board[x - 1][y] = TARGET;
  }
  if (x < 8 && enemy_board[x + 1][y] == UNKNOWN) {
    enemy_board[x + 1][y] = TARGET;
  }
  if (y > 0 && enemy_board[x][y - 1] == UNKNOWN) {
    enemy_board[x][y - 1] = TARGET;
  }
  if (y < 8 && enemy_board[x][y + 1] == UNKNOWN) {
    enemy_board[x][y + 1] = TARGET;
  }
}

// == main ==
void record_result(int x, int y, char line[]) {
  char result = line[13];

  if (result == 'B') {
    enemy_board[x][y] = BSHIP;
  } else if (result == 'C') {
    enemy_board[x][y] = CSHIP;
  } else if (result == 'D') {
    // TODO: Dが１マス飛ばしで２つあった場合、間は確実にNOSHIPになる。
    enemy_board[x][y] = DSHIP;
  } else if (result == 'S') {
    enemy_board[x][y] = SSHIP;

    record_noship(x - 1, y);
    record_noship(x, y - 1);
    record_noship(x, y + 1);
    record_noship(x + 1, y);
  } else if (result == 'R') {
    enemy_board[x][y] = ROCK;
  } else {
    enemy_board[x][y] = NOSHIP;
  }

  if (is_ship(x, y)) {
    check_next(x, y);
    record_diag(x, y);
    finish_ship(x, y);
    set_target(x, y);
  }
}

// =====================================================================================================

void print_board(void) {
  int ix, iy;

  for (iy = BD_SIZE - 1; iy >= 0; iy--) {
    printf("%2d ", iy);
    for (ix = 0; ix < BD_SIZE; ix++) {
      switch (enemy_board[ix][iy]) {

      case TARGET:
        printf("\x1b[31mT ");
        break;
      case UNKNOWN:
        printf("\x1b[30mU ");
        break;
      case NOSHIP:
        printf("\x1b[33mN ");
        break;
      case ROCK:
        printf("\x1b[30mR ");
        break;
      case BSHIP:
        printf("\x1b[34mB ");
        break;
      case CSHIP:
        printf("\x1b[34mC ");
        break;
      case DSHIP:
        printf("\x1b[34mD ");
        break;
      case SSHIP:
        printf("\x1b[34mS ");
        break;
      default:
        break;
      }
    }
    printf("\x1b[37m\n");
  }

  printf("  ");
  for (ix = 0; ix < BD_SIZE; ix++) {
    printf("%2d", ix);
  }
  printf("\n   a b c d e f g h i\n\n");
}

void handle_messages(void) {
  char line[MSG_LEN];

  srand(getpid());
  init_board();

  while (true) {
    receive_from_ref(line);

    if (message_has_type(line, "name?")) {
      respond_with_name();
    } else if (message_has_type(line, "deployment?")) {
      respond_with_deployment();
    } else if (message_has_type(line, "shot?")) {
      respond_with_shot();
    } else if (message_has_type(line, "shot-result:")) {
      record_result(cur_x, cur_y, line);
      printf("[%s] result: %c\n", myName, line[13]);
      print_board();
    } else if (message_has_type(line, "end:")) {
      break;
    } else {
      printf("[%s] ignoring message: %s", myName, line);
    }
  }
}

int main() {
  client_make_connection();
  handle_messages();
  client_close_connection();
  return 0;
}
