test:
	docker build . -f tests/Dockerfile -t siadat/animated-resize.nvim:tests
	docker run -it siadat/animated-resize.nvim:tests
