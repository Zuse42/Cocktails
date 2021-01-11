#!/bin/bash
./prod/rel/video/bin/video eval "Video.ReleaseTasks.migrate"
./prod/rel/video/bin/video start
