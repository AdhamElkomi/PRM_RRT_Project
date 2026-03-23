# PRM vs RRT Path Planning

This project focuses on the implementation and comparison of two classical path planning algorithms: PRM (Probabilistic Roadmap) and RRT (Rapidly-exploring Random Tree).

The goal was to study how both methods behave in the same 2D environment with obstacles, and to compare their performance in terms of computation time and path quality.

---

## Project Overview

A 2D environment was created with:
- rectangular and circular obstacles  
- a defined start point  
- a defined goal point  

Both algorithms were applied on the same map to keep the comparison consistent.

---

## PRM (Probabilistic Roadmap)

PRM works by first sampling random points in the free space, then connecting nearby nodes to form a graph.  
Once the roadmap is built, a shortest path algorithm is used to connect the start to the goal.

This approach generally produces clean and relatively optimal paths, but becomes slower when the number of nodes increases.

---

## RRT (Rapidly-exploring Random Tree)

RRT builds a tree starting from the initial position and expands it step by step toward randomly sampled points.

It is faster and simpler to implement, but the resulting path is usually less direct due to the random exploration.

---

## Results

### Example Environment

![Environment](images/env.png)

### PRM Result

![PRM](images/prm.png)

### RRT Result

![RRT](images/rrt.png)

---

## Performance Comparison

### Computation Time

![Time](images/time.png)

PRM becomes more expensive as the number of nodes increases due to graph construction.  
RRT remains faster in most cases.

### Path Length

![Length](images/length.png)

PRM produces shorter and more stable paths.  
RRT tends to generate longer paths because of its exploration strategy.

---

## Conclusion

Both algorithms have their advantages.

PRM is more suitable when path quality is important, especially in static environments.  
RRT is more efficient when quick exploration is needed.

The choice between the two depends on the application constraints.


---

## Author

Adham Ahmed Salah Ali  
Engineering student in Robotics
