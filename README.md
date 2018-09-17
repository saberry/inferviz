# inferViz

## Origins

At the 2018 RStudio::conf, Di Cook gave a great presentation about inference through visualization. The concept of Few's/Berk's "interoccular traumatic impact" was not new to me, but Di's take was something completely different. Interestingly, I remember having done something on mturk related to her presentation; unfortunately, I was not really thinking critically about the meaning of the task at the time.

Shortly after seeing Di's talk, I decided to put something together for the sake of teaching the concept of visual inference to students. 

## Use 

The main function, simviz, was created with the intention of being easy for students to immediately start using.


```r
inferviz::simViz(mtcars, mpg, hp, answer = FALSE)
```

```
## Good luck!
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)

