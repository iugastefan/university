#define _FILE_OFFSET_BITS 64
#define FUSE_USE_VERSION 30
#include <dirent.h>
#include <fuse.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <zip.h>
#include <dirent.h>
static char *filename;
struct zip *ziparchive;

static int do_getattr(const char *path, struct stat *st) {

  struct zip_stat *stat = (struct zip_stat *)malloc(sizeof(struct zip_stat));
  int val =
      zip_stat(ziparchive, path + 1, ZIP_FL_NODIR | ZIP_FL_ENC_GUESS, stat);
  /* printf("%d %s\n", stat->flags, path); */

  st->st_uid = getuid();
  st->st_gid = getgid();
  st->st_atime = time(NULL);
  st->st_ino = stat->index;

  if ((stat->valid | ZIP_STAT_MTIME) && strcmp(path, "/") != 0)
    st->st_mtime = stat->mtime;
  else
    st->st_mtime = time(NULL);

  if (strcmp(path, "/") == 0 || strcmp(path, ".") == 0 ||
      strlen(strchr(path, '/')) == 1) {
    printf("strcm %s\n", path);
    st->st_mode = S_IFDIR | 0755;
    st->st_nlink = 2;
    st->st_size = 4096;
  } else {
    st->st_mode = S_IFREG | 0644;
    st->st_nlink = 1;
    st->st_size = stat->size;
  }

  if (val == -1 && strcmp(path, "/") != 0) {
    return -1;
  }
  return 0;
}
static int do_readdir(const char *path, void *buffer, fuse_fill_dir_t filler,
                      off_t offset, struct fuse_file_info *fi) {
  printf("%d \n", S_IFDIR | 0755);

  filler(buffer, ".", NULL, 0);
  filler(buffer, "..", NULL, 0);
    struct stat *st1 = (struct stat *)malloc(sizeof(struct stat));
    st1->st_mode = DT_DIR << 12 | S_IFDIR | 0755;
    printf("readdir  %s %u\n",   "asd", st1->st_mode);

    st1->st_ino = 2;

  filler(buffer, "asd1", st1, 0);
  /* filler(buffer, "asd1/", NULL, 0); */
  ziparchive = zip_open(filename, 0, NULL);
  zip_int64_t files_number = zip_get_num_entries(ziparchive, 0);
  for (int i = 0; i < files_number; i++) {
    struct stat *st = (struct stat *)malloc(sizeof(struct stat));
    char *name = zip_get_name(ziparchive, i, ZIP_FL_ENC_GUESS);
    //do_getattr(name, st);
    st->st_mode = S_IFDIR | 755;
    st->st_ino = 1;
    name[strlen(name) - 1] = '\0';
    printf("readdir %d %s %s %ud\n", i, name, path, st->st_mode);
    filler(buffer, name, st, 0);
  }

  /* pthread_mutex_unlock(&lock); */
  return 0;
}

static int do_mkdir(const char *name, mode_t mode) {

  int z = zip_dir_add(ziparchive, name, ZIP_FL_ENC_GUESS);
  return z;
}

static int do_read(const char *path, char *buffer, size_t size, off_t offset,
                   struct fuse_file_info *fi) {

  zip_file_t *file = zip_fopen(ziparchive, path + 1, ZIP_FL_ENC_GUESS);
  if (file == NULL) {
    return -1;
  }
  zip_fseek(file, offset, 0);
  zip_int64_t bytes_read = zip_fread(file, buffer, size);

  return bytes_read;
}

static struct fuse_operations operations = {
    .getattr = do_getattr, .readdir = do_readdir, .read = do_read,
    /* .mkdir = do_mkdir, */
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
  filename = argv[1];
  char *mountpoint = argv[2];

  struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
  fuse_opt_parse(&args, NULL, NULL, myfs_opt_proc);
  fuse_opt_add_arg(&args, mountpoint);
  fuse_opt_add_arg(&args, "-f");

  return fuse_main(args.argc, args.argv, &operations, NULL);
}
