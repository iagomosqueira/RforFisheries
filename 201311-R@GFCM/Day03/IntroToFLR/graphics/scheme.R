# scheme.R - DESC
# scheme.R

# Copyright 2003-2013 FLR Team. Distributed under the GPL 2 or later
# Maintainer: Iago Mosqueira, JRC
# $Id: $
# Created:
# Modified:

png(file="scheme.png")

par(mai=c(0.2, 0.2, 0.5, 0.2), lwd=2)
plot(seq(3, 13, len=2)~seq(1, 8, len=2), type="n", xlab="", ylab="", main="FLR packages' development model", axes=FALSE)
segments(2, 10, 7, 10, lwd=2, col="black")
segments(2, 10, 2, 8, lwd=2, col="black")
segments(7, 10, 7, 6, lwd=2, col="black")
segments(4.5, 12, 4.5, 6, lwd=2, col="black")
segments(3.8, 6, 5.2, 6, lwd=2, col="black")
segments(3.8, 6, 3.8, 4, lwd=2, col="black")
segments(5.2, 6, 5.2, 4, lwd=2, col="black")
points(4.5, 12, pch=21, cex=12, bg="white")
points(2, 8, pch=22, cex=12, bg="white")
points(4.5, 8, pch=21, cex=12, bg="white")
points(3.8, 4, pch=22, cex=12, bg="white")
points(5.2, 4, pch=22, cex=12, bg="white")
points(7, 8, pch=22, cex=12, bg="white")
points(7, 6, pch=22, cex=12, bg="white")
text(4.5, 12, "FLCore", font=2, cex=0.9)
text(2, 8, "FLEDA", font=2, cex=0.9)
text(4.5, 8, "FLAssess", font=2, cex=0.9)
text(3.8, 4, "FLa4a", font=2, cex=0.9)
text(5.2, 4, "FL...", font=2, cex=0.9)
text(7, 8, "FLash", font=2, cex=0.9)
text(7, 6, "FLBRP", font=2, cex=0.9)

dev.off()
