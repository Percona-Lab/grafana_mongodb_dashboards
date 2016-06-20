GIT_REPO=$(shell git remote -v | awk '/origin.*fetch/{gsub(".git$$","",$$2); print $$2}')
GIT_COMMIT=$(shell git show | head -1 | cut -d' ' -f2)

all: dashboards/*.json
	echo "== Building dashboards with git repo/hash: $(GIT_REPO) / $(GIT_COMMIT) =="
	find dashboards/* -type f -exec sed -i -e s@"%{GIT_REPO}%"@"$(GIT_REPO)"@g -e s@"%{GIT_COMMIT}%"@"$(GIT_COMMIT)"@g {} \;
	find dashboards/* -type f -exec ./template-cleaner.py {} \;
