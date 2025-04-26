.PHONY: update overwrite baseline


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
baseline:
	@echo "Showing repository baseline"
	@git rev-parse HEAD

update-readme-baseline:
	@echo "🔎 Finding new baseline SHA..."
	@NEW_BASELINE=$$(git rev-parse HEAD) && \
	echo "✍️  Updating README.md with baseline $$NEW_BASELINE..." && \
	sed -i.bak -E "s/(\"baseline\": \")[a-f0-9]{40}(\")/\1$${NEW_BASELINE}\2/" README.md && \
	rm -f README.md.bak && \
	echo "✅ README.md updated with new baseline: $$NEW_BASELINE"