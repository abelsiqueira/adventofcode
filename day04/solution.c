// Reference
// http://stackoverflow.com/questions/7627723/how-to-create-a-md5-hash-of-a-string-in-c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <openssl/md5.h>

char *str2md5(const char *str, int length) {
	int n;
	MD5_CTX c;
	unsigned char digest[16];
	char *out = (char*)malloc(33);

	MD5_Init(&c);

	while (length > 0) {
		if (length > 512) {
			MD5_Update(&c, str, 512);
		} else {
			MD5_Update(&c, str, length);
		}
		length -= 512;
		str += 512;
	}

	MD5_Final(digest, &c);

	for (n = 0; n < 16; ++n) {
		snprintf(&(out[n*2]), 16*2, "%02x", (unsigned int)digest[n]);
	}

	return out;
}

int main(int argc, char **argv) {
  int i = 0, j;
  char *output, input[64];
  int found;
	if (argc < 2) {
    printf("Need argument");
	}
  while (1) {
    sprintf(input, "%s%d", argv[1], i);
    output = str2md5(input, strlen(input));
    found = 1;
    for (j = 0; j < 6; j++) {
      if (output[j] != '0') {
        found = 0;
        break;
      }
      if (j == 4) {
        printf("%d -> %s\n", i, output);
      }
    }
    if (found) {
      printf("%d -> %s\n", i, output);
      break;
    }
    i++;
    free(output);
  }
	return 0;
}
