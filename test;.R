

test_vec = c()

test_vec = c(test_vec, 'k')
test_vec = c(test_vec, 'j')
test_vec = c(test_vec, 1)

test_vec

class(test_vec)

test_vec[-1] # call by value

test_vec


for (i in 1:range(length(test_vec))){
  print(i)
}


d1 <- c(1,2,3,4)
d2 <- c("Kim", "Lee", "Choi", "Park")
d3 <- data.frame(cust_id = d1, last_name = d2)

d3

d3 <- d3[c(1, 3),]

d3


test <- iris
head(test)
class(test)

test.index

test <- test[-1, ]
head(test)

test <- test[-2, ]
head(test)


rm_idx = c()
rm_idx = c(rm_idx, 1, 2, 2, 5)
rm_idx

rm_idx = unique(rm_idx)
rm_idx

head(test)
head(test[-rm_idx, ])



test





















