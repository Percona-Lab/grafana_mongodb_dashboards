GIT_HASH=$(shell git show | head -1 | cut -d" " -f2)

all:
	echo "== Building dashboards with git hash: $(GIT_HASH) =="
	find dashboards/* -type f -exec sed -i -e s/%{GIT_HASH}%/$(GIT_HASH)/g {} \;
	find dashboards/* -type f -exec ./template-cleaner.py {} \;
