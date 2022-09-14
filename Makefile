run:
	docker compose up

start:
	docker compose up -d

stop:
	docker compose stop

logs:
	docker compose logs -f

test-find:
	curl --request POST --url 'http://localhost:3000/find' --header 'Content-Type: application/json' --data '{"html":{"url":"https://en.wikipedia.org/wiki/Main_Page","javascript":false},"find":{"text":{"where":"div#mp-welcome h1 span"},"href":{"where":"div#mp-welcome h1 span a","attr":"href"},"list":{"where":"ul#footer-places li","find":{"text":{"where":"a"},"href":{"where":"a","attr":"href"}}}}}'

test-find-tranform:
	curl --request POST --url 'http://localhost:3000/find' --header 'Content-Type: application/json' --data '{"html":{"url":"https://en.wikipedia.org/wiki/Main_Page","javascript":false},"find":{"text":{"where":"div#mp-welcome h1 span","transform":[["replace","to",""],["replace","  "," "]]},"href":{"where":"div#mp-welcome h1 span a","attr":"href"},"list":{"where":"ul#footer-places li","find":{"text":{"where":"a"},"href":{"where":"a","attr":"href"}}}}}'

test-find-convert:
	curl --request POST --url 'http://localhost:3000/find' --header 'Content-Type: application/json' --data '{"html":{"url":"https://en.wikipedia.org/wiki/Main_Page","javascript":false},"find":{"text":{"where":"div#mp-welcome h1 span","transform":[["replace","Welcome to Wikipedia","1"]],"convert": "integer"},"href":{"where":"div#mp-welcome h1 span a","attr":"href"},"list":{"where":"ul#footer-places li","find":{"text":{"where":"a"},"href":{"where":"a","attr":"href"}}}}}'

test-find-exclude:
	curl --request POST --url 'http://localhost:3000/find' --header 'Content-Type: application/json' --data '{"html":{"url":"https://en.wikipedia.org/wiki/Main_Page","javascript":false},"find":{"text":{"where":"div#mp-welcome h1 span","transform":[["replace","Welcome to Wikipedia","1"]],"convert": "integer","exclude":[["<=", 1]]},"href":{"where":"div#mp-welcome h1 span a","attr":"href"},"list":{"where":"ul#footer-places li","find":{"text":{"where":"a"},"href":{"where":"a","attr":"href"}}}}}'

test-find-html:
	curl --request POST --url 'http://localhost:3000/find' --header 'Content-Type: application/json' --data '{"html":"<h1 title=\"title-test\">H1 Value</h1>","find":{"text":{"where":"h1"},"title":{"where":"h1","attr":"title"}}}'

test-html:
	curl --request POST --url 'http://localhost:3000/html' --header 'Content-Type: application/json' --data '{"html":{"url":"https://en.wikipedia.org/wiki/Main_Page","javascript":false}}'
