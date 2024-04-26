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
    "Bc8d8e8f8 Cb1b2b3 Cf1g1h1 Da6b6 Dh6h7 Dh3i3 Sd0 Se3 Sf5 Sd5 ";
enum ship { UNKNOWN, ROCK, NOSHIP, BSHIP, CSHIP, DSHIP, SSHIP };

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

int target_x = -1;
int target_y = -1;
bool is_end() {
  return true;
  return (target_x < 0);
}
// このフラグを用いて、いま追いかけている戦艦があるかどうかを判定。
// なにも手がかりがない場合はtrue, 手がかりがある場合はfalse.

int get_length(enum ship target) {
  switch (target) {
  case UNKNOWN:
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

bool is_ship(int x, int y) {
  if (x < 0 || 8 < x || y < 0 || 8 < y)
    return false;
  enum ship value = enemy_board[x][y];
  return (value == BSHIP || value == CSHIP || value == DSHIP || value == SSHIP);
}

int count_ship_length(int x, int y) {
  int i;
  int start;
  int count_row = 0;
  int count_row_max = 0;
  for (i = 0; i < 9; i++) {
    // printf("\nTest in count..(%d, %d): count_row = %d, start = %d, i = %d\n",
    // x, y, count_row, start, i);
    if (is_ship(i, y)) {
      // printf("found ship at %d, %d", i, y);
      if (count_row == 0) {
        start = i;
      }
      count_row++;

      if (count_row > count_row_max && (start - x) * (i - x) <= 0) {
        count_row_max = count_row;
      }
    } else {
      count_row = 0;
      start = i;
    }
  }
  int j;
  int count_col = 0;
  int count_col_max = 0;
  for (j = 0; j < 9; j++) {
    if (is_ship(x, j)) {
      if (count_col == 0) {
        start = j;
      }
      count_col++;
      if (count_col > count_col_max && (start - x) * (j - x) <= 0) {
        count_col_max = count_col;
      }
    } else {
      count_col = 0;
      start = j;
    }
  }

  if (count_row_max > count_col_max)
    return count_row_max;
  return count_col_max;
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

void calc_next(int *x, int *y) {
  int move = 0;
  enum ship target_type = enemy_board[target_x][target_y];

  // upward
  if (is_ship(target_x, target_y + 1)) {
    move = 1;
    while (true) {
      move++;
      if (enemy_board[target_x][target_y + move] == UNKNOWN) {
        *x = target_x;
        *y = target_y + move;
        return;
      }
      if (!is_ship(target_x, target_y + move)) {
        break;
      }
    }
  }
  // downward
  if (is_ship(target_x, target_y - 1)) {
    move = -1;
    while (true) {
      move--;
      if (enemy_board[target_x][target_y + move] == UNKNOWN) {
        *x = target_x;
        *y = target_y + move;
        return;
      }
      if (!is_ship(target_x, target_y + move)) {
        break;
      }
    }
  }
  // left
  if (is_ship(target_x - 1, target_y)) {
    move = -1;
    while (true) {
      move--;
      if (enemy_board[target_x + move][target_y] == UNKNOWN) {
        *x = target_x + move;
        *y = target_y;
        return;
      }
      if (!is_ship(target_x, target_y + move)) {
        break;
      }
    }
  }
  // right
  if (is_ship(target_x + 1, target_y)) {
    move = +1;
    while (true) {
      move++;
      if (enemy_board[target_x + move][target_y] == UNKNOWN) {
        *x = target_x + move;
        *y = target_y;
        return;
      }
      if (!is_ship(target_x, target_y + move)) {
        break;
      }
    }
  }
  // otherwise (error)
  random_xy(x, y);
}

void respond_with_shot(void) {
  // printf("\nTest of count_ship_length(%d, %d): Result = %d\n", cur_x, cur_y,
  // count_ship_length(cur_x, cur_y));

  char shot_string[MSG_LEN];
  int x, y;

  if (is_end) {
    random_xy(&x, &y);
  } else {
    calc_next(&x, &y);
  }
  printf("[%s] shooting at %d%d ... ", myName, x, y);
  sprintf(shot_string, "%d%d", x, y);
  send_to_ref(shot_string);
  cur_x = x;
  cur_y = y;
}

// ==== recording ====

void record_noship(int x, int y) {
  if (0 <= x || x <= 8 || 0 <= y || y <= 8) {
    if (enemy_board[x][y] == UNKNOWN) {
      enemy_board[x][y] = NOSHIP;
    }
  }
}

void record_diag(int x, int y) {
  // 船があった時に斜めをNSHIPにする
  // ROCKがあるからelse ifでいい
  if (is_ship(x, y)) {
    if (x == 0) {
      record_noship(x + 1, y - 1);
      record_noship(x + 1, y + 1);
    } else if (x == 8) {
      record_noship(x - 1, y - 1);
      record_noship(x - 1, y + 1);
    } else if (y == 0) {
      record_noship(x - 1, y + 1);
      record_noship(x + 1, y + 1);
    } else if (y == 8) {
      record_noship(x - 1, y - 1);
      record_noship(x + 1, y - 1);
    } else {
      record_noship(x - 1, y - 1);
      record_noship(x - 1, y + 1);
      record_noship(x + 1, y - 1);
      record_noship(x + 1, y + 1);
    }
  } else {
    // printf("No ship here: x=%d, y=%d", x, y);
  }
}

void finish_ship(int x, int y) {
  printf("\nFinishing a ship at (%d, %d)\n", x, y);
  enum ship ship_type = enemy_board[x][y];
  // 一つの船を撃沈したときに周囲をNOSHIPにする
  // 撃沈したときにその船の端を撃ったと仮定する
  // record_diagで斜めは埋められているので、両端の２点をNOSHIPにすればいい。
  if (is_ship(x, y + 1)) {
    record_noship(x, y - 1);
    record_noship(x, y + get_length(ship_type));
  } else if (is_ship(x, y - 1)) {
    record_noship(x, y + 1);
    record_noship(x, y - get_length(ship_type));
  } else if (is_ship(x - 1, y)) {
    record_noship(x + 1, y);
    record_noship(x - get_length(ship_type), y);
  } else if (is_ship(x + 1, y)) {
    record_noship(x - 1, y);
    record_noship(x + get_length(ship_type), y);
  }
}

void check_next(int x, int y) {
  // 隣に船がある場合に逆サイドをNOSHIPにする
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

  check_next(x, y);
  record_diag(x, y);

  // targetの更新
  // printf("DEBUG: count_ship_length(%d, %d) = %d, Ship lenght: %d", x, y,
  // count_ship_length(x, y), get_length(enemy_board[x][y]));
  if (is_ship(x, y)) {
    if (count_ship_length(x, y) == get_length(enemy_board[x][y])) {
      finish_ship(x, y);
      target_x = -1;
      target_y = -1;
    } else if (is_end()) {
      target_x = x;
      target_y = y;
    }
  }
}

// =====================================================================================================

void print_board(void) {
  int ix, iy;

  for (iy = BD_SIZE - 1; iy >= 0; iy--) {
    printf("%2d ", iy);
    for (ix = 0; ix < BD_SIZE; ix++) {
      switch (enemy_board[ix][iy]) {
      case UNKNOWN:
        printf("\x1b[37mU ");
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
  printf("\n\n");
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
