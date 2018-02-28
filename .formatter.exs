[
  inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
  locals_without_parens: [
    inject: 2
  ],
  export: [
    locals_without_parens: [
      inject: 2
    ]
  ]
]
