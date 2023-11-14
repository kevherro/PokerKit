.PHONY: fmt
fmt:
		swift-format format --configuration .swift-format \
			--recursive \
			--parallel \
			--in-place \
			Sources/* Tests/* Package.swift
