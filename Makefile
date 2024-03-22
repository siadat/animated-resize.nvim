test:
	docker build ./tests -t siadat/animated-resize.nvim:tests
	docker run -it siadat/animated-resize.nvim:tests
