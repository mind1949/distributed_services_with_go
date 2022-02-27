package log

type Config struct {
	Segment SegmentConfig
}

type SegmentConfig struct {
	MaxStoreBytes uint64
	MaxIndexBytes uint64
	InitialOffset uint64
}
