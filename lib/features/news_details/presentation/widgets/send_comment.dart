import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/news_details/presentation/bloc/news_details_bloc.dart';


sendComment (NewsDetailsBloc newsDetailsBloc){
    return BlocBuilder(
                                                      bloc: newsDetailsBloc,
                                                      builder: (context, state) {
                                                        if (state
                                                            is LoadingComment) {
                                                              log('state is loading');
                                                          return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                        backgroundColor: AppColor.yellow,color: AppColor.purple,)
                                                          );
                                                        }
                                                    
                                                        return container(
                                                            hight: h(50),
                                                            width: w(80),
                                                            borderRadius: 10,
                                                            color:
                                                                Colors.green[900],
                                                            child: text(
                                                                text: 'ارسال',
                                                                fontfamily: 'marai',
                                                                color:
                                                                    Colors.white));
                                                      },
                                                    );
}