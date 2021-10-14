module test

go 1.15

require (
	github.com/go-kiss/monkey v0.0.0-20210912230757-40cda447d0e3 // indirect
	github.com/huandu/go-tls v1.0.1 // indirect
)

replace (
	github.com/go-kiss/monkey v0.0.0 => ./monkey
	github.com/huandu/go-tls v1.0.1 => ./go-tls
)
