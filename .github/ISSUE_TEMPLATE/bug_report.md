name: Bug Report
description: File a bug report
title: '[BUG] <title>'
body:
  - type: textarea
    attributes:
      label: Bug Description
      description: >-
        What is the bug? Please provide a snippet of output including
        any errors and the messages logged before the error.
        Verbose or debug logs are preferred but please ensure all secrets and
        other sensitive information has been removed.
      placeholder: I did ... and ... happened.
    validations:
      required: true
  - type: textarea
    attributes:
      label: Expected Behavior
      description: |
        What did you expect to happen? For example, expected output or behavior.
    validations:
      required: true
  - type: textarea
    attributes:
      label: Steps To Reproduce
      description: >-
        Please provide the steps that can be used to reproduce this behavior.

        If possible, please include an example project (GitHub repository) that
        is capable of reproducing this behavior.
        The example project should only include the minimum required code
        to reproduce the issue.
        It should not depend on any external resource.
      value: |
        Example project: ...

        1.
        2.
        3.
        ...
    validations:
      required: true
  - type: textarea
    attributes:
      label: Anything else?
      description: |
        Links? References? Anything that will give us more context about the issue you are encountering!

        Tip: You can attach images or log files by clicking this area to highlight it and then dragging files in.
    validations:
      required: false