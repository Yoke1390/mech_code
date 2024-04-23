#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <my-ipc.h>
#include <client-side.h>
#include <redundant.h>
#include <public.h>

const char myName[] = "03240236";
const char deployment[] = "Ba3a4a5a6 Cc1c2c3 Cc5c6c7 De1e2 De4e5 De7e8 Sg1 Sg3 Sg5 Sg7 ";

enum ship {
  UNKNOWN,
  ROCK,
  NOSHIP,
  BSHIP,
  CSHIP,
  DSHIP,
  SSHIP
};

int cur_x,cur_y;
enum ship enemy_board[BD_SIZE][BD_SIZE];    // BD_SIZE is 9 (defined in public.h)

void respond_with_name(void)
{
  char *str = (char *)malloc(sizeof(myName));
  strcpy(str, myName);
  send_to_ref(str);
  free(str);
}

void respond_with_deployment(void)
{
  char *str = (char *)malloc(sizeof(deployment));
  strcpy(str, deployment);
  send_to_ref(str);
  free(str);
}


// copied from ex4.c
void init_board(void){
  int ix, iy;

  for(ix = 0; ix < (BD_SIZE); ix++)
  {
    for(iy = 0; iy < (BD_SIZE); iy++)
    {
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

void respond_with_shot(void)
{
  char shot_string[MSG_LEN];
  int x, y;
  
  while (TRUE)
  {
    x = rand() % BD_SIZE;
    y = rand() % BD_SIZE;

    if (enemy_board[x][y] == UNKNOWN){
      break;
    }
	
  }
  printf("[%s] shooting at %d%d ... ", myName, x, y);
  sprintf(shot_string, "%d%d", x, y);
  send_to_ref(shot_string);
  cur_x = x;
  cur_y = y;
}

bool is_ship(char result){
  return (result == 'B' || result == 'C' || result == 'D' || result == 'S');
}

bool is_ship_xy(int x, int y){
  value = enemy_board[x][y];
  return (value == 'B' || value == 'C' || value == 'D' || value == 'S');
}

void record_noship(int x, int y){
  if (enemy_board[x][y] == UNKNOWN){
    enemy_board[x][y] = NOSHIP;
  }
}

void check_next(int x, int y){
  if (is_ship_xy(x-1, y), is_ship_xy(x+1, y)){
    if (y < 8) record_noship(x, y+1);
    if (y > 0) record_noship(x, y-1);
  }
  if (is_ship_xy(x, y-1), is_ship_xy(x, y+1)){
    if (x < 8) record_noship(x+1, y);
    if (x > 0) record_noship(x-1, y);
  }
}

void record_diag(int x, int x, char result){
  if (is_ship(result))
  {
    if (x == 0){
      record_noship(x+1, y-1); 
      record_noship(x+1, y+1); 
    }
    else if (x == 8){
      record_noship(x-1, y-1); 
      record_noship(x-1, y+1); 
    }
    else if (y == 0){
      record_noship(x-1, y+1); 
      record_noship(x+1, y+1); 
    }
    else if (y == 8){
      record_noship(x-1, y-1); 
      record_noship(x+1, y-1); 
    }
    else {
      record_noship(x-1, y-1); 
      record_noship(x-1, y+1); 
      record_noship(x+1, y-1); 
      record_noship(x+1, y+1); 
    }
  }
}

void record_result(int x,int y,char line[])
{
  char result = line[13];

  check_next(x, y);
  record_diag(x, y, result)


  if(result=='B')
  {
    //====kokokara====

    enemy_board[x][y] = BSHIP;

    //====kokomade====
  }
  else if(result=='C')
  {
    //====kokokara====

    enemy_board[x][y] = CSHIP;

    //====kokomade====
  }
  else if(result=='D')
  {
    //====kokokara====

    enemy_board[x][y] = DSHIP;

    //====kokomade====
  }
  else if(result=='S')
  {
    enemy_board[x][y] = SSHIP;
    
    record_noship(x-1, y); 
    record_noship(x, y-1); 
    record_noship(x, y+1); 
    record_noship(x+1, y); 
  }
  else if(result=='R')
  {
    enemy_board[x][y] = ROCK;
  }
  else
  {
    enemy_board[x][y] = NOSHIP;
  }
}

// =====================================================================================================

void print_board(void){
  int ix, iy;

  for (iy = BD_SIZE - 1; iy >= 0; iy--)
  {
    printf("%2d ", iy);
    for (ix = 0; ix < BD_SIZE; ix++)
    {
      switch(enemy_board[ix][iy])
      {
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
  for (ix = 0; ix < BD_SIZE; ix++)
  {
    printf("%2d", ix);
  }
  printf("\n\n");
}

void handle_messages(void)
{
  char line[MSG_LEN];

  srand(getpid());
  init_board();
  
  while (TRUE)
  {
    receive_from_ref(line);

    if(message_has_type(line, "name?"))
    {
      respond_with_name(); 
    }
    else if(message_has_type(line, "deployment?"))
    {
       respond_with_deployment(); 
    }
    else if(message_has_type(line, "shot?"))
    {
      respond_with_shot(); 
    }
    else if(message_has_type(line, "shot-result:"))
    {
      record_result(cur_x,cur_y,line);
      printf("[%s] result: %c\n", myName, line[13]);
      print_board();
    }
    else if(message_has_type(line, "end:"))
    {
      break;
    }
    else
    {
      printf("[%s] ignoring message: %s", myName, line);
    }
  }
}

int main()
{
  client_make_connection();
  handle_messages();
  client_close_connection();
  return 0;
}
