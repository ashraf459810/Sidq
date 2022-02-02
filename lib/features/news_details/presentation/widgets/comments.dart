   import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidq/Widgets/custom_list_view.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/features/news_details/presentation/bloc/news_details_bloc.dart';

commentsWidget (NewsDetailsBloc newsDetailsBloc , var comments){return 
         BlocBuilder(
                                                bloc: newsDetailsBloc,
                                                builder: (context, state) {
                                                  if (state
                                                      is AddCommentState) {
                                                    comments = state.comments;
                                                  }

                                                  return customlistview(
                                                    scroll: false,
                                                    direction: 'vertical',
                                                    padding: 10,
                                                    controller:
                                                        ScrollController(),
                                                    itemcount: comments.length,
                                                    function: (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                                alignment: Alignment
                                                                    .topRight,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            10))),
                                                                // constraints: BoxConstraints(minHeight: h(50),maxWidth: w(250),maxHeight: h(120),minWidth:w(250) ),

                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: text(
                                                                    fontfamily: 'marai',
                                                                    text: comments[
                                                                        index],
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              );
   }