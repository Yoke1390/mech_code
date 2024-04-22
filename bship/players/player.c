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
      //======kokokara======

      enemy_board[ix][iy] = UNKNOWN;

      //======kokomade======
    }
  }

  //rock is out of bound


  //======kokokara======
  
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

  //======kokomade======
}

void respond_with_shot(void)
{
  char shot_string[MSG_LEN];
  int x, y;
  
  while (TRUE)
  {
    x = rand() % BD_SIZE;
    y = rand() % BD_SIZE;
    //=====kokokara====

    if (enemy_board[x][y] == UNKNOWN){
      break;
    }
	
    //=====kokomade=====
  }
  printf("[%s] shooting at %d%d ... ", myName, x, y);
  sprintf(shot_string, "%d%d", x, y);
  send_to_ref(shot_string);
  cur_x = x;
  cur_y = y;
}

void record_noship(int x, int y){
  if (enemy_board[x][y] == UNKNOWN){
    enemy_board[x][y] = NOSHIP;
  }
}

bool is_ship(char result){
  return (result == 'B' || result == 'C' || result == 'D' || result == 'S');
}

void check_next(int x, int y){
  // todo: もっと安全だがシンプルな方法
  enum ship *up = &(enemy_board[x][y+1]);
  enum ship *down = &(enemy_board[x][y-1]);
  enum ship *left = &(enemy_board[x-1][y]);
  enum ship *right = &(enemy_board[x+1][y]);
  
  if (is_ship(*up) || is_ship(*down)){
    *right = NOSHIP;
    *left = NOSHIP;
  }
  if (is_ship(*left) || is_ship(*right)){
    *up = NOSHIP;
    *down = NOSHIP;
  }
}

void record_result(int x,int y,char line[])
{
  char result = line[13];
  check_next(x, y);

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
    //====kokokara====

    enemy_board[x][y] = SSHIP;
    
    record_noship(x-1, y); 
    record_noship(x, y-1); 
    record_noship(x, y+1); 
    record_noship(x+1, y); 

    //====kokomade====
  }
  else if(result=='R')
  {
    //====kokokara====

    enemy_board[x][y] = ROCK;

    //====kokomade====
  }
  else
  {
    //====kokokara====

    enemy_board[x][y] = NOSHIP;

    //====kokomade====
  }
}

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
