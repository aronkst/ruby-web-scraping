run:
	docker compose up

start:
	docker compose up -d

stop:
	docker compose stop

logs:
	docker compose logs -f

test-html:
	curl --request POST --url 'http://localhost:3000/html' --header 'Content-Type: application/json' --data '{"html":{"url":"https://en.wikipedia.org/wiki/Main_Page","javascript":false}}'