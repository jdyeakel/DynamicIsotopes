rm(list=c(ls()))

#Simulated consumer code
library(ellipse)
library(gtools)
library(RColorBrewer)


#Import prey data
prey <- read.csv("Prey.csv",header=TRUE)
nprey <- length(prey[,1])
ellip_prey <- list(nprey); CI <- 0.95
#build ellipses for prey
for (i in 1:nprey) {
  #Sigma <- matrix(c(prey$CSD[i],0,0,prey$NSD[i]),2,2)
  mu <- c(prey$CM[i],prey$NM[i])
  ellip_prey[[i]] <- ellipse(x=0,scale = c(prey$CSD[i],prey$NSD[i]),centre=mu,level=CI)
}

#Number of consumers
N = 1

#Body size of consumers (kg)
bmass <- rep(20,N)

#Time-steps
t_term <- 5000

#Matrix for saving consumer C values
c_m <- matrix(0,N,t_term)

#Matrix for saving consumer N values
n_m <- matrix(0,N,t_term)

#Matrix cor saving consumer prey bouts
d_m <- matrix(0,N,t_term)

#Initial consumer isotope values
#For now, the initial value will just be the means of the prey
c_init <- rep(mean(prey$CM),N)
n_init <- rep(mean(prey$NM),N)

c_m[,1] <- c_init
n_m[,1] <- n_init

#0 indicates generalist; 1 indicates specialist
#theta <- rep(1,N)
#theta <- rep(1,N)

#Dirichlet distribution for p_vector
#p_vector is the proportional contribution of prey to the diet of consumer
#p_vector determines a per-diem vector of proportional contributions
#given the Dirichlet from which it is drawn
Dir_param <- matrix(1,N,nprey)

Dir_param[7] <- 20


#Which prey item does each consumer specialize on?
s_prey <- sample(nprey,N,replace=TRUE)
#cumulative distribution
#plot(sapply(seq(1,12),function(x){length(which(s_prey<x))/length(s_prey)}))

#Loop over time
for (t in 1:(t_term-1)) {
  
  #Prey abundance dynamics
  
  
  
  #Loop over consumers
  for (i in 1:N) {
    #Define the carbon, nitrogen isotope values of body at time t
    cb <- c_m[i,t]
    nb <- n_m[i,t]
    
    #Define body mass of consumer
    #mb <- bmass[i]
    
    #Determine next prey item
    
    #With probability equal to e_gen[i], they will specialize
    #With probability equal to 1-e_gen[i], they will draw from prey randomly
    
    #RANDOM DRAW VERSION
    #Draw random value
    #     rdraw <- runif(1)
    #     if (rdraw < theta[i]) {
    #       #If specialist, select it's preferred prey
    #       next_prey <- s_prey[i]
    #     } else {
    #       #If generalist, randomly select from all prey
    #       next_prey <- sample(nprey,1,replace=TRUE)
    #     }
    #     #Randomly draw prey isotope values from known mean and sd
    #     cp_mean <- prey$CM[next_prey]
    #     cp_sd <- prey$CSD[next_prey]
    #     cp <- rnorm(1,cp_mean,cp_sd)
    #     np_mean <- prey$NM[next_prey]
    #     np_sd <- prey$NSD[next_prey]
    #     np <- rnorm(1,np_mean,np_sd)
    
    
    #DIRICHLET VERSION
    #draw proportional contribution vector from random dirichlet
    p_vec <- numeric(nprey)
    #if (N == 1) {
    #  p_vec[1:nprey-1] <- rdirichlet(1,Dir_param)
    #} else {
    p_vec[1:nprey] <- rdirichlet(1,Dir_param[i,])
    #}
    #p_vec[nprey] <- 1 - sum(p_vec)
    #Draw prey values from each prey
    cp_vec <- sapply(seq(1,nprey),function(x){rnorm(1,prey$CM[x],prey$CSD[x])})
    np_vec <- sapply(seq(1,nprey),function(x){rnorm(1,prey$NM[x],prey$NSD[x])})
    #Calculate weighted average
    cp <- p_vec %*% cp_vec
    np <- p_vec %*% np_vec
    
    #Prey biomass
    #set to one if each prey is to be equally weighted
    #(assume 1 kg of each thing is eaten rather than at individual level)
    #mp <- 1 #prey$Biomass[next_prey]
    
    #Define incorporation rate
    incorp_rate <- 0.05
    
    #weights for body size
    #f <- mb/(mb + mp)
    f <- 1 - incorp_rate
    
    cb_next <- f*cb + (1-f)*cp
    nb_next <- f*nb + (1-f)*np
    
    c_m[i,t+1] <- cb_next
    n_m[i,t+1] <- nb_next
    
  } #end i
  
} #end t
