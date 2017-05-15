tran_probs = matrix(0.0, nrow = 4, ncol = 4)
tran_probs[1,2] = 1.0
tran_probs[2,3] = 0.5
tran_probs[2,4] = 0.5
tran_probs[3,1] = 0.5
tran_probs[3,4] = 0.5
tran_probs[4,1] = 1.0

probs = matrix(0.0, nrow = 9, ncol = 4)
for(i in 1:4) {
  for(j in 1:9) {
    c = matrix(0.0, nrow = 4, ncol = 1)
    c[i,1] = 1
    prob = t(tran_probs)
    k = 1;
    while(k <= (j-1)) {
      prob = prob %*% t(tran_probs)
      k = k +1
    }
    f_prob = prob %*% c
    probs[j,i] = f_prob[1]
  }
}

print(probs)