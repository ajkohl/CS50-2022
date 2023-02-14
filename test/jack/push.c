bool push(int n) {
   if(!isFull()) {
      top = top + 1;
      stack[top] = data;
   } else {
      printf("Could not insert element; Stack is full.\n");
   }
}

bool isfull() {
   if(top == MAXSIZE)
      return true;
   else
      return false;
}

//https://www.tutorialspoint.com/data_structures_algorithms/stack_program_in_c.htm