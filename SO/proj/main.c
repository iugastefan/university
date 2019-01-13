#define _FILE_OFFSET_BITS 64
#define FUSE_USE_VERSION 30
#include <archive.h>
#include <archive_entry.h>
#include <fuse.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

static int do_getattr(const char *path, struct stat *st) {
  printf("[getattr] Called\n");
  printf("\tAttributes of %s requested\n", path);
  st->st_uid = getuid();
  st->st_gid = getgid();
  st->st_atime = time(NULL);
  st->st_mtime = time(NULL);
  if (strcmp(path, "/") == 0) {
    st->st_mode = S_IFDIR | 0755;
    st->st_nlink = 2;
  } else {
    st->st_mode = S_IFREG | 0644;
    st->st_nlink = 1;
    st->st_size = 1024;
  }

  return 0;
}
static int do_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
                      off_t offset, struct fuse_file_info *fi) {
  /* printf("--> Getting The List of Files of %s\n", path); */

  filler(buffer, ".", NULL, 0);  // Current Directory
  filler(buffer, "..", NULL, 0); // Parent Directory

  if (strcmp(path, "/") ==
      0) // If the user is trying to show the files/directories of the root
         // directory show the following
  {
    filler(buffer, "file54", NULL, 0);
    filler(buffer, "file349", NULL, 0);
  }

  return 0;
}
static int do_read(const char *path, char *buffer, size_t size, off_t offset,
                   struct fuse_file_info *fi) {
  char file54Text[] = "Hello World From File54!";
  char file349Text[] = "Hello World From File349!";
  char *selectedText = NULL;
  if (strcmp(path, "/file54") == 0)
    selectedText = file54Text;
  else if (strcmp(path, "/file349") == 0)
    selectedText = file349Text;
  else
    return -1;
  memcpy(buffer, selectedText + offset, size);
  return strlen(selectedText) - offset;
}
static struct fuse_operations operations = {
    .getattr = do_getattr,
    .readdir = do_readdir,
    .read = do_read,
};
static int myfs_opt_proc(void *data, const char *arg, int key,
                         struct fuse_args *outargs) {
  if (key == FUSE_OPT_KEY_NONOPT) {
    return 0;
  }
  return 1;
}
int main(int argc, char *argv[]) {
  if (argc != 3)
    return 1;
  char *file = argv[1];
  char *mountpoint = argv[2];
  printf("%s %s", file, mountpoint);

  struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
  fuse_opt_parse(&args, NULL, NULL, myfs_opt_proc);
  fuse_opt_add_arg(&args, mountpoint);
  fuse_opt_add_arg(&args, "-f");
  return fuse_main(args.argc, args.argv, &operations, NULL);
}
