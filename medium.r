library(ggplot2)
library(animint2)

# function n its derivative
f <- function(x) 4*x^3 - 6*x^2 - 30*x + 80
df <- function(x) 12*x^2 - 12*x - 30

# curve
curve_df <- data.frame(
  x = seq(-6.2, 7.1, length.out = 400)
)
curve_df$y <- f(curve_df$x)

# iterations to be performed 
x_current <- 7.15
n_iter <- 20

iter_df <- data.frame()
step_df <- data.frame()

for(i in 1:n_iter){
  
  y_current <- f(x_current)
  slope <- df(x_current)
  
  if(abs(slope) < 1e-6) break
  
  x_next <- x_current - y_current / slope
  
  # store point for convergence
  iter_df <- rbind(iter_df, data.frame(
    iteration = i,
    x = x_current,
    y = y_current
  ))
  
  # vertical drop (BLUE, the f(x) value at current x)
  step_df <- rbind(step_df, data.frame(
    iteration = i,
    x = x_current,
    y = 0,
    xend = x_current,
    yend = y_current,
    type = "vertical"
  ))
  
  # tangent (RED, tangent at current point n helps reach closer to the root)
  step_df <- rbind(step_df, data.frame(
    iteration = i,
    x = x_current,
    y = y_current,
    xend = x_next,
    yend = 0,
    type = "tangent"
  ))
  
  x_current <- x_next
}

# convergence to reach close to the root
conv_df <- data.frame(
  iteration = iter_df$iteration,
  value = abs(iter_df$y)
)

# dynamic root label
root_label_df <- data.frame(
  iteration = iter_df$iteration,
  x = 3.5 - 3,
  y = 1200 - 400,
  label = paste0("Current root: ", round(iter_df$x, 5))
)

# MAIN PLOT (plottng the 2 graphs)
p1 <- ggplot() +
  
  geom_line(data = curve_df, aes(x = x, y = y), color = "black") +
  geom_hline(yintercept = 0, color = "gray50") +
  geom_segment(data = step_df, aes(x = x, y = y, xend = xend, yend = yend, color = type), alpha = 0.2) +
  geom_segment(data = step_df, aes(x = x, y = y, xend = xend, yend = yend, color = type),size = 1.2, showSelected = "iteration") +
  scale_color_manual(values = c("vertical" = "blue", "tangent" = "red")) +
  geom_point(data = iter_df, aes(x = x, y = y), size = 2, alpha = 0.4) +
  geom_point(data = iter_df, aes(x = x, y = y), size = 4, clickSelects = "iteration") +
  
  #dynamic root text
  geom_text( data = root_label_df, aes(x = x, y = y, label = label, key = iteration), size = 10, hjust = 0, showSelected = "iteration" ) +
  coord_cartesian(ylim = c(-1000, 1000)) + 
  theme_bw() +
  
  labs(
    title = " Newton-Raphson for: f(x) = 4x³ - 6x² - 30x + 80", x = "x", y = "f(x)")

# Convergence: how Newton Raphson method approaches the root w every iteration
p2 <- ggplot(conv_df, aes(x = iteration, y = value)) +
  
  geom_line(size = 1) +
  geom_tallrect(aes(xmin = iteration - 0.5, xmax = iteration + 0.5), clickSelects = "iteration", alpha = 0.2) +
  geom_point( aes(x = iteration, y = value), size = 3, showSelected = "iteration") +
  scale_y_log10() +
  theme_bw() +
  
  labs(
    title = "|f(x)| vs Iteration (log scale)", x = " Number of Iterations", y = "|f(x)|")

# animint
viz <- animint(
  main = p1,
  convergence = p2,
  time = list(variable = "iteration", ms = 1200)
)

animint2dir(viz, "newton-rhapson-method")