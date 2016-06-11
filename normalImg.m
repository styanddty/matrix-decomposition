function [X_normal] = normalImg(X)
X_min=min(min(X))
high=max(max(X))-X_min
X_normal=((X-X_min)/high)*255