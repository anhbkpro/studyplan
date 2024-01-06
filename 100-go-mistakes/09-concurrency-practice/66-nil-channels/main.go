package main

import (
	"fmt"
)

// For closed channel
// write to a closed channel will cause error: (panic: send on closed channel)
// read from closed channel is a non-blocking operation.
// For nil channel
// write to or read from a nil channel will block forever, and this behaviour doesn't useless, see solution in merge3() function.

func main() {
	// var ch chan int
	// <-ch // read from nil channel will block forever, but read from closed channel is a non-blocking operation.
	ch1 := make(chan int)
	close(ch1)
	// try to write to a closed channel will cause panic: send on closed channel
	// ch1 <- 42
	fmt.Println(<-ch1, <-ch1) // read from closed channel is a non-blocking operation.
	v, open := <-ch1
	fmt.Println(v, open) // using the `open` boolean, we can now see whether ch1 is still open.

	c1 := gen(1, 3, 5, 7, 9)
	c2 := gen(0, 2, 4, 6, 8)
	out := merge3(c1, c2)
	// Consume the output.
	for v := range out { // loop over a channel using range operator breaks when the channel is closed.
		fmt.Println(v)
	}
}

func gen(nums ...int) <-chan int {
	out := make(chan int)
	go func() {
		for _, n := range nums {
			out <- n
		}
		close(out)
	}()

	return out
}

func sq(in <-chan int) <-chan int {
	out := make(chan int)
	go func() {
		for n := range in {
			out <- n * n
		}
		close(out)
	}()
	return out
}

// The main issue with this first version is that we receive from ch1 and then we receive from ch2.
// It means we won't receive from ch2 until ch1 is closed.
func merge1(ch1, ch2 <-chan int) <-chan int {
	out := make(chan int, 1)
	go func() {
		for v := range ch1 { // range operator breaks when the channel ch1 is closed (gen function handles this)
			out <- v
		}
		for v := range ch2 {
			out <- v
		}
		close(out)
	}()
	return out
}

// The second solution a for/select doesn't catch when either ch1 or ch2 is closed.
// Because we can not catch when a channel is closed, so for/select still read from
// a closed channel (read from closed channel is a non-blocking operation) -> so a receiver will
// repeatedly receive an integer equal to zero.
func merge2(ch1, ch2 <-chan int) <-chan int {
	out := make(chan int, 1)
	go func() {
		for {
			select {
			case v := <-ch1: // for/select doesn't catch when either ch1 or ch2 is closed but range can -> so we will keep entering and publishing a zero integer to the merged channel.
				out <- v
			case v := <-ch2:
				out <- v
			}
		}
		// close(out) // one problem is that this code is unreachable
	}()

	return out
}

// this function uses nil channels to solve problem dealing with concurrent code.
func merge3(ch1, ch2 <-chan int) <-chan int {
	out := make(chan int, 1)
	go func() {
		for ch1 != nil || ch2 != nil { // continues if at least one channel isn't nil
			select {
			case v, open := <-ch1:
				if !open {
					ch1 = nil // assigns ch1 to a nil channel once closed
					break
				}
				out <- v
			case v, open := <-ch2:
				if !open {
					ch2 = nil // assigns ch2 to a nil channel once closed
					break
				}
				out <- v
			}
		}
		close(out)
	}()

	return out
}
