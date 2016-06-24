PREFIX?=/var/lib/grafana/dashboards
GIT_REPO=$(shell git remote -v | awk '/origin.*fetch/{gsub(".git$$","",$$2); print $$2}')
GIT_COMMIT=$(shell git show | head -1 | cut -d' ' -f2)

all: build

build: dashboards/*.json
	echo "== Building dashboards with git repo/hash: $(GIT_REPO) / $(GIT_COMMIT) =="
	rm -rf build
	cp -dpR dashboards build
	find build/* -type f -exec ./template-cleaner.py {} \;
	find build/* -type f -exec sed -i -e s@"%{GIT_REPO}%"@"$(GIT_REPO)"@g -e s@"%{GIT_COMMIT}%"@"$(GIT_COMMIT)"@g {} \;

install: build
	mkdir -p $(PREFIX)
	cp -vf build/*.json $(PREFIX)/

clean:
	rm -rf build
