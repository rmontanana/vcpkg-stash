.PHONY: update overwrite


update:
	@echo "Updating all submodules..."
	# Create/update <port>.json + baseline entries
	@vcpkg --x-builtin-ports-root=./ports \
      --x-builtin-registry-versions-dir=./versions \
      x-add-version --all --verbose

overwrite:
	@echo "Updating with overwrite-version all submodules..."
	# Create/update <port>.json + baseline entries
	@vcpkg --x-builtin-ports-root=./ports \
      --x-builtin-registry-versions-dir=./versions \
      x-add-version --all --verbose --overwrite-version