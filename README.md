# API JSON calls with Haskell

## What ?

A simple project showing how to make calls to an API and parsing JSON using
HTTP Conduit and Aeson.

## Why ?

Because JSON is very popular and use it with Haskell is really cool.

## How ?

Take a look to app/Main.hs and run it with the commands:

```bash
cd hello-conduit
cabal build
cabal exec -- hello-conduit
```

## Where ?

This sample is based in the tutorial at https://github.com/snoyberg/http-client/blob/master/TUTORIAL.md

Some documentation can be found at https://hackage.haskell.org/package/http-conduit-2.3.8/docs/Network-HTTP-Simple.html
