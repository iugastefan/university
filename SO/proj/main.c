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
#include <zip.h>
static char *filename;
struct archive *archive;
struct zip *ziparchive;

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
  ziparchive = zip_open(filename, NULL, NULL);
  zip_int64_t files_number = zip_get_num_entries(ziparchive, NULL);
  for (int i = 0; i < files_number; i++) {
    filler(buffer, zip_get_name(ziparchive, i, ZIP_FL_ENC_GUESS), NULL, 0);
  }

  /* if (strcmp(path, "/") == */
  /*     0) // If the user is trying to show the files/directories of the root
   */
  /*        // directory show the following */
  /* { */
  /*   int r; */
  /*   struct archive_entry *entry; */
  /*   if ((r = archive_read_open_filename(archive, filename, 10240))) { */
  /*     printf("read open err"); */
  /*     exit(1); */
  /*   } */
  /*   for (;;) { */
  /*     r = archive_read_next_header(archive, &entry); */
  /*     if (r == ARCHIVE_EOF) */
  /*       break; */
  /*     filler(buffer, archive_entry_pathname(entry), NULL, 0); */
  /*   } */
  /* } */
  /* archive_read_close(archive); */
  return 0;
}
static int do_read(const char *path, char *buffer, size_t size, off_t offset,
                   struct fuse_file_info *fi) {
  /* char file54Text[] = "Hello World From File54!"; */
  /* char file349Text[] = "Hello World From File349!"; */
  /* char *selectedText = NULL; */
  /* if (strcmp(path, "/file54") == 0) */
  /*   selectedText = file54Text; */
  /* else if (strcmp(path, "/file349") == 0) */
  /*   selectedText = file349Text; */
  /* else */
  /*   return -1; */
  /* memcpy(buffer, selectedText + offset, size); */
  zip_file_t *file = zip_fopen(ziparchive, path+1, ZIP_FL_ENC_GUESS);
  if(file ==NULL)
    printf("null, %s\n", path);
  /* zip_fseek(file,size,offset); */
  zip_int64_t bytes_read = zip_fread(file, buffer, size);
  if (bytes_read == -1)
    printf("err");
  return bytes_read;
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
  filename = argv[1];
  char *mountpoint = argv[2];

  archive = archive_read_new();
  archive_read_support_format_all(archive);

  struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
  fuse_opt_parse(&args, NULL, NULL, myfs_opt_proc);
  fuse_opt_add_arg(&args, mountpoint);
  fuse_opt_add_arg(&args, "-f");
  return fuse_main(args.argc, args.argv, &operations, NULL);
}
