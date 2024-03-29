import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/news_details/data/models/news_details.dart';
import 'package:sidq/features/news_details/presentation/bloc/news_details_bloc.dart';

addVote(NewsDetailsBloc newsDetailsBloc , int trueVotesNumber, int falseVotesNumber,bool voteTrue,bool voteFalse,NewsDetailsModel  newsDetailsModel){
  return      
                                                 BlocBuilder(
                                        
                                                    bloc: newsDetailsBloc,
                                                    builder: (context, state) {
                                                      // if (state is LoadingVote) {
                                                      //   return const LinearProgressIndicator(color: Colors.grey,);
                                                      // }
                                                      if (state is AddVoteState) {
                                                
                                                        trueVotesNumber = state
                                                            .voteResponseModel
                                                            .result!
                                                            .trueVotesCounts!;
                                                        falseVotesNumber = state
                                                            .voteResponseModel
                                                            .result!
                                                            .falseVotesCounts!;
                                                      }
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              
                                                                voteTrue = true;
                                                                voteFalse = false;
                                                              
                                                              newsDetailsBloc.add(
                                                                  AddVoteEvent(
                                                                      newsDetailsModel
                                                                          .result!
                                                                          .id!,
                                                                      true));
                                                            },
                                                            child: container(
                                                              borderRadius: 10,
                                                              width: w(150),
                                                              color: voteTrue
                                                                  ? Colors
                                                                      .grey[400]
                                                                  : AppColor.yellow,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Icon(
                                                                    Icons.check,
                                                                    color: AppColor.purple
                                                                        ,
                                                                    size: 35.sp,
                                                                  ),
                                                                  text(fontfamily: 'marai',
                                                                  fontWeight: FontWeight.bold,
                                                                      text:
                                                                          'خبر صحيح',
                                                                      color: 
                                                                          AppColor.purple),
                                                                  // SizedBox(width: w(10),),
                                                                  text(
                                                                    fontWeight: FontWeight.bold,
                                                                      text: trueVotesNumber
                                                                          .toString(),
                                                                      color: AppColor.purple
                                                                          ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              voteTrue = false;
                                                              voteFalse = true;
                                                        
                                                              newsDetailsBloc.add(
                                                                  AddVoteEvent(
                                                                      newsDetailsModel
                                                                         .result!
                                                                          .id!,
                                                                      false));
                                                            },
                                                            child: container(
                                                              borderRadius: 10,
                                                              width: w(150),
                                                              color: voteFalse
                                                                  ? Colors
                                                                      .grey[400]
                                                                  : AppColor.yellow,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Icon(
                                                                    Icons.clear,
                                                                    color: AppColor.purple
                                                                         ,
                                                                    size: 35.sp,
                                                                  ),
                                                                  text(fontfamily: 'marai',
                                                                  fontWeight: FontWeight.bold,
                                                                      text:
                                                                          'خبر خاطئ',
                                                                      color: AppColor.purple
                                                                          ),
                                                                  // SizedBox(width: w(10),),
                                                                  text(
                                                                    fontWeight: FontWeight.bold,
                                                                      text: falseVotesNumber
                                                                          .toString(),
                                                                      color: AppColor
                                                                          .purple),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                           
                                           
}