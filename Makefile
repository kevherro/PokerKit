.PHONY: fmt
fmt:
		swift-format format --configuration .swift-format \
			--recursive \
			--parallel \
			--in-place \
			Sources/* Tests/* Package.swift

.PHONY: docc
docc:
		swift package --allow-writing-to-directory ./Documentation \
			generate-documentation \
			--target Evaluators \
			--output-path ./Documentation

.PHONY: docc-preview
docc-preview:
		swift package --disable-sandbox preview-documentation \
			--target Evaluators
