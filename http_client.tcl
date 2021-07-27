#!/usr/bin/env tclsh

proc argv_is_null {var} {
	if {$var eq ""} {
		puts "Passe algum endereço ao script."
		exit 1
	}
}

proc request {channel server} {
	proc reading_socket {channel} {			
		while {[gets $channel line] >= 0} {
			puts $line
		}
		
		if {[eof $channel]} {
			close $channel
		}
	}

    set string_request "GET / HTTP/1.1\nhost: $server\nConnection: close\n\n"
	puts $channel $string_request
	flush $channel
	reading_socket $channel
}

set server [join $argv]
argv_is_null $server
set channel [socket $server 80]
request $channel $server
