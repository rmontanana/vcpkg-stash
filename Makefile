.PHONY: update overwrite baseline update-readme-baseline


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
	# @echo "🔎 Finding new baseline SHA..."
	# @NEW_BASELINE=$$(git rev-parse HEAD) && \
	# echo "✍️  Updating README.md with baseline $$NEW_BASELINE..." && \
	# sed -i.bak -E "/https:\/\/github\.com\/rmontanana\/vcpkg-stash/{n;s/(\"baseline\": \")[a-f0-9]{40}(\")/\1$${NEW_BASELINE}\2/}" README.md && \
	# rm -f README.md.bak && \
	# echo "✅ README.md updated with new baseline: $$NEW_BASELINE"
	@echo "🔎 Finding current private baseline SHA..."
	@NEW_BASELINE=$$(git rev-parse HEAD) && \
	OLD_PRIVATE_BASELINE=$$(awk '/https:\/\/github.com\/rmontanana\/vcpkg-stash/ {getline; match($$0, /"baseline": "([a-f0-9]{40})"/, arr); print arr[1]}' README.md) && \
	OLD_MICROSOFT_BASELINE=$$(awk '/https:\/\/github.com\/microsoft\/vcpkg/ {getline; match($$0, /"baseline": "([a-f0-9]{40})"/, arr); print arr[1]}' README.md) && \
	echo "➡️  Old private baseline: $$OLD_PRIVATE_BASELINE" && \
	echo "➡️  Old Microsoft baseline: $$OLD_MICROSOFT_BASELINE" && \
	echo "➡️  New private baseline: $$NEW_BASELINE" && \
	\
	# Update only the private baseline line\n\
	sed -i.bak -E "/https:\/\/github\.com\/rmontanana\/vcpkg-stash/{n;s/(\"baseline\": \")[a-f0-9]{40}(\")/\1$${NEW_BASELINE}\2/}" README.md && \
	\
	# Verify update success\n\
	NEW_PRIVATE_BASELINE_IN_FILE=$$(awk '/https:\/\/github.com\/rmontanana\/vcpkg-stash/ {getline; match($$0, /"baseline": "([a-f0-9]{40})"/, arr); print arr[1]}' README.md) && \
	NEW_MICROSOFT_BASELINE_IN_FILE=$$(awk '/https:\/\/github.com\/microsoft\/vcpkg/ {getline; match($$0, /"baseline": "([a-f0-9]{40})"/, arr); print arr[1]}' README.md) && \
	\
	if [ "$$NEW_PRIVATE_BASELINE_IN_FILE" != "$$NEW_BASELINE" ]; then \
		echo "❌ ERROR: Private baseline did not update correctly."; exit 1; \
	fi && \
	if [ "$$NEW_MICROSOFT_BASELINE_IN_FILE" != "$$OLD_MICROSOFT_BASELINE" ]; then \
		echo "❌ ERROR: Microsoft baseline was modified unexpectedly."; exit 1; \
	fi && \
	echo "✅ README.md updated safely. Private baseline is now $$NEW_BASELINE" && \
	rm -f README.md.bak