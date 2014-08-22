WTF is Ray Tracing?
-------------------

I guess I kind of want to be able to project a 3D environment onto a 2D surface, and I guess that's what ray tracing does? With any luck this repo will gradually be transformed into that kind of technology, or else it will be suuuuuuper slow.

#### Discoveries ####

I started with a small screen resolution, 160 x 144 pixels (#GBJam style). The idea was, since this is ray tracing and I have to think about WxH rays... I should "start small" to avoid performance issues. I implemented my own little Vector library to help with this, and I thought "I'll make them immutable and cache the 160 x 144 vectors from player to draw plane, then just reuse and rotate them." An amazing thing happened: it was super slow! I did a bit of snooping to see just what was slow, and it turns out it was my Vectors. So I replaced them with a table containing 3 entries and some functions that operate on these tables... and it turns out that is much better. Cool!
