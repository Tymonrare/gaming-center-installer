from getver import get_file_last_version
import urllib.request
import sys
import time

def reporthook(count, block_size, total_size):
    global start_time
    if count == 0:
        start_time = time.time() - 1
        return
    duration = time.time() - start_time
    progress_size = int(count * block_size)
    speed = int(progress_size / (1024 * duration))
    percent = int(count * block_size * 100 / total_size)
    sys.stdout.write("\r...%d%%, %d MB, %d KB/s, %d seconds passed" %
                    (percent, progress_size / (1024 * 1024), speed, duration))
    sys.stdout.flush()

urladress = sys.argv[1]
filepath = sys.argv[2]
fileext = '.7z'
savename = sys.argv[3]

lastver = get_file_last_version(urladress, filepath)
url = urladress+'/'+filepath+'v'+str(lastver)+fileext

print('Download ver.', lastver, '\nfrom:', url)

urllib.request.urlretrieve(url, savename, reporthook)