#include <stdio.h>
#include <stdlib.h>

struct saved_regs {
  double *reg1, *reg2, *reg32, *reg_pc;
};

struct pcb_type {
  int proc_id;
  int proc_priority;
  int proc_state;
  int proc_class;
  struct saved_regs *reg_pt;
};

struct process_list {
  struct pcb_type* pcb_pt;
  struct process_list* who_follows;
};

struct process_list *start = NULL;

int allocated_id = 1;
int allocated_prio = 1;
int allocated_class = 1;

struct saved_regs* alloc_saved_regs();
struct pcb_type* create_new_pcb();

void add_new_process(struct pcb_type* );
void print_process();

int main() {
  for (int i = 0; i < 12; i++) {
    struct pcb_type* process = create_new_pcb();
    add_new_process(process);
  }

  int index = 12;
  while (start != NULL) {
    printf("index of process: %d \n", index);
    index--;
    print_process(start -> pcb_pt);
    start = start -> who_follows;
  }

}

void add_new_process(struct pcb_type *process) {
  struct process_list* processList = malloc(sizeof(struct process_list));
  processList -> pcb_pt = process;
  if (start == NULL) {
    start = processList;
    processList -> who_follows = NULL;
  } else {
    processList -> who_follows = start;
    start = processList;
  }
}

struct saved_regs* alloc_saved_regs() {
  struct saved_regs* reg = malloc(sizeof(struct saved_regs));

  reg->reg1   = malloc(1);
  reg->reg2   = malloc(1);
  reg->reg32  = malloc(1);
  reg->reg_pc = malloc(1);
  return reg;
}

struct pcb_type* create_new_pcb() {
  struct pcb_type* process = malloc(sizeof(struct pcb_type));
  process -> proc_class    = allocated_class;
  process -> proc_id       = allocated_id++;
  process -> proc_priority = allocated_prio;
  process -> reg_pt        = alloc_saved_regs();

  return process;
}

void print_process(struct pcb_type *process) {
  printf("address_pcb = %u \n", process -> reg_pt);
  printf("proc_id = %d \n", process -> proc_id);
  printf("proc_class = %d \n", process -> proc_class);
  printf("proc_priority = %d \n", process -> proc_priority);
  printf("proc_state = %d \n", process -> proc_state);

  printf("\n");
}
