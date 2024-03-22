test:
	docker build . -f tests/Dockerfile --build-arg PLUGIN_NAME=animated-resize.nvim -t siadat/animated-resize.nvim:tests
	docker run -it siadat/animated-resize.nvim:tests
