run:
	docker compose up

start:
	docker compose up -d

stop:
	docker compose stop

logs:
	docker compose logs -f

test-find-html:
	curl --request POST --url 'http://localhost:3000/find' --header 'Content-Type: application/json' --data '{"html":"<h1 title=\"title-test\">H1 Value</h1>","find":{"text":{"where":"h1"},"title":{"where":"h1","attr":"title"}}}'

test-html:
	curl --request POST --url 'http://localhost:3000/html' --header 'Content-Type: application/json' --data '{"html":{"url":"https://en.wikipedia.org/wiki/Main_Page","javascript":false}}'
