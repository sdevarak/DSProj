#DS501 - Case Study 1 - Mining Twitter DATA                 
#Problem 1
tweets = searchTwitter('#silk+#fashion', n=1000, resultType='mixed')
stweetsDF = twListToDF(tweets)
#tweetwords <- str_extract_all(stweetsDF$text, "[[:alnum:]]")
#wordlist<-lapply(str_extract_all(stweetsDF$text, "[[:alnum:]]"), paste, collapse=" ")
#Problem 2.1 
wordlist <- unlist(lapply(str_extract_all(stweetsDF$text,"[a-zA-Z][a-zA-Z]+"),paste,collapse=" "))
wordcount <- wfm(wordlist)
freqwords <- freq_terms(wordlist, n=30, stopwords = c("http", "silk", "fashion", "on", "and", "rt", "https", "co"))
plot(freqwords)

#Problem 2.2 - Top 10 tweets
o <- order(stweetsDF$retweetCount)
newo = tail(o, 30)
unique_tweets = unique(stweetsDF$text[newo])
unique_idx = newo[!duplicated(stweetsDF$text[newo])]
tbl=melt(unique_tweets,id=unique_idx)

#Problem 2.3
#Find top 10 #hashtags and user mentions
htlist <- unlist(lapply(str_extract_all(stweetsDF$text, "#\\S+"), paste, collapse=" "))
freq_terms(htlist, 10, stopwords = c("silk", "fashion"))

umlist <- unlist(lapply(str_extract_all(stweetsDF$text, "^@\\w+|\\s@\\w+"), paste, collapse=" "))
freq_terms(umlist, 10)

# Problem 3
marykom = getUser('MCMarykom')
followers = twListToDF((marykom$getFollowers()))
tbl_flwrs=data.table(followers$id[1:20],followers$name[1:20])
View(tbl_flwrs)
dim(followers)
friends = twListToDF((marykom$getFriends()))
tbl_frnds=data.table(friends$id[1:20],friends$name[1:20])
View(tbl_friends)
length(friends)
fr_fl = intersect(followers$id, friends$id)
fr_tbl = data.table(friends$id[which(fr_fl %in% followers$id)], friends$name[which(fr_fl %in% followers$id)] )

#Problem 4:
word_network_plot(stweetsDF$text, stweetsDF$latitude, stweetsDF$longitude)
