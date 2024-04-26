#include <client-side.h>
#include <my-ipc.h>
#include <public.h>
#include <redundant.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

const char myName[] = "03240236";
const char deployment[] =
    "Ba3a4a5a6 Cc1c2c3 Cc5c6c7 De1e2 De4e5 De7e8 Sg1 Sg3 Sg5 Sg7 ";

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

char prev_results[4]; // 前回のショットの記録を残す

int target_x = -1;
int target_y = -1;
bool is_end() { return (target_x < 0); }
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

bool is_ship(char result) {
  return (result == 'B' || result == 'C' || result == 'D' || result == 'S');
}

bool is_ship_xy(int x, int y) {
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
    if (is_ship_xy(i, y)) {
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
    if (is_ship_xy(x, j)) {
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

void calc_next(int *x, int *y) {
  if (is_ship_xy(*x, *y + 1)) {
  }
}

void respond_with_shot(void) {
  // printf("\nTest of count_ship_length(%d, %d): Result = %d\n", cur_x, cur_y,
  // count_ship_length(cur_x, cur_y));

  char shot_string[MSG_LEN];
  int x, y;

  if (is_end) {
    while (true) {
      x = rand() % BD_SIZE;
      y = rand() % BD_SIZE;

      if (enemy_board[x][y] == UNKNOWN) {
        break;
      }
    }
  } else {
    calc_next(&x, &y);
  }
  printf("[%s] shooting at %d%d ... ", myName, x, y);
  sprintf(shot_string, "%d%d", x, y);
  send_to_ref(shot_string);
  cur_x = x;
  cur_y = y;
}

void record_noship(int x, int y) {
  if (enemy_board[x][y] == UNKNOWN) {
    enemy_board[x][y] = NOSHIP;
  }
}

void check_next(int x, int y) {
  if (is_ship_xy(x - 1, y), is_ship_xy(x + 1, y)) {
    if (y < 8)
      record_noship(x, y + 1);
    if (y > 0)
      record_noship(x, y - 1);
  }
  if (is_ship_xy(x, y - 1), is_ship_xy(x, y + 1)) {
    if (x < 8)
      record_noship(x + 1, y);
    if (x > 0)
      record_noship(x - 1, y);
  }
}

void record_diag(int x, int y, char result) {
  if (is_ship(result)) {
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
  }
}

void record_result(int x, int y, char line[]) {
  char result = line[13];

  check_next(x, y);
  record_diag(x, y, result);

  if (result == 'B') {
    //====kokokara====

    enemy_board[x][y] = BSHIP;

    //====kokomade====
  } else if (result == 'C') {
    //====kokokara====

    enemy_board[x][y] = CSHIP;

    //====kokomade====
  } else if (result == 'D') {
    //====kokokara====

    enemy_board[x][y] = DSHIP;

    //====kokomade====
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

  // 記録を更新
  prev_results[3] = prev_results[2];
  prev_results[2] = prev_results[1];
  prev_results[1] = prev_results[0];
  prev_results[0] = result;
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
