package main

func main() {
	// An unbuffered channel (or synchronous channel) can be created by either ommitting the size or providing a 0 size
	ch1 := make(chan int)    // a unbuffered channel
	ch2 := make(chan int, 0) // a unbuffered channel
	// Using an unbuffered channel, the sender will block until the receiver receives data from the channel.

	// Conversely, a buffered channel has a capacity, size >= 1
	ch3 := make(chan int, 1)
	// With a buffered channel, a sender can send messages while the channel isn't full. Once the channel is full, it will
	// block until a receiver goroutine receives a message
	ch4 := make(chan int, 1)
	ch4 <- 1 // non-blocking
	ch4 <- 2 // blocking

	// An unbuffered channel enables synchronization
	// An buffered channel doesn't provide any strong synchronization
}
