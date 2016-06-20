all:
	find dashboards/* -type f -exec ./template-cleaner.py {} \;
