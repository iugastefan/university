#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  pid_t pid = fork();
  if (pid < 0)
    return pid;
  else if (pid == 0) {
    printf("My PID=%d, Child PID=%d\n", getppid(), getpid());
    char *argv[] = {"ls", ".", NULL};
    execve("/bin/ls", argv, NULL);
  } else {
    wait(NULL);
    printf("Child %d finished\n", pid);
  }
  return 0;
}
