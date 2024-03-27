import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:lueesa_app/core/services/voting_service.dart';
import 'package:stacked/stacked.dart';

List<Map<String, dynamic>> electionInfo = [
  {
    "post": "Public Relations Officer",
    "nominees": ["Chuka Nzeih", "Oshevire Odiri", "Champion Ogbonlaiye"]
  },
  {
    "post": "Social Director",
    "nominees": [
      "David Omotayo",
      "Ozumba Peace",
      "Ogbueze Austin",
      "Omeniwan Elvis"
    ]
  },
  {
    "post": "Sports Director",
    "nominees": ["Abe Daniel", "Ajinomison Daniel", "Ndada Blessing"],
  },
  {
    "post": "Welfare Secretary",
    "nominees": ["Chuka Nzeih"]
  },
  {
    "post": "Financial Secretary",
    "nominees": ["Ademola Olutayo"]
  },
  {
    "post": "General Secretary",
    "nominees": ["Kizito Ihekerem", "Vivian Nduka"]
  },
  {
    "post": "Vice President Academics",
    "nominees": ["Ojo Oluwatobi"]
  },
  {
    "post": "Vice President Administration",
    "nominees": ["Elijah Oguntolu", "Kizito Ihekerem", "Njoku Precious"],
  },
  {
    "post": "President",
    "nominees": ["Etete Kelvin", "Madumere Onyekachi", "Abolarin Daniella"]
  }
];

class VotingViewModel extends BaseViewModel {
  final VotingService _votingService = VotingService();
  TextEditingController regCtr = TextEditingController();

  submit(BuildContext context, String email, String uid) async {
    bool hasUserVoted = await _votingService.hasUserVoted(uid);
    bool isUser400 = await _votingService.isUser400(regCtr.text, email);
    bool hasEmptyChoice = _votingService.hasEmptyChoice();
    log("Is user in 400 --> $isUser400");

    if (!hasUserVoted &&
        !hasEmptyChoice &&
        isUser400 &&
        regCtr.text.isNotEmpty) {
      try {
        for (Map<String, dynamic> i in _votingService.votersChoice) {
          _votingService.increaseVote(i["post"], i["choice"]);
        }
        bool result = await _votingService.updateVoteStatus(uid);
        if (result && context.mounted) {
          IconSnackBar.show(
              context: context,
              label: "Your vote has been uploaded😊",
              snackBarType: SnackBarType.save);
        }
      } catch (e) {
        log("Error while submitting --> $e");
      }
    }
    if (context.mounted) {
      if (hasUserVoted) {
        IconSnackBar.show(
            context: context,
            label: "Haven't you voted before?🌚",
            snackBarType: SnackBarType.fail);
      }
      if ((_votingService.hasEmptyChoice())) {
        IconSnackBar.show(
            context: context,
            label: "Pick someone for every post🙃",
            snackBarType: SnackBarType.fail);
      }
      if (!isUser400) {
        IconSnackBar.show(
            context: context,
            label: "You are not in 400!😠",
            snackBarType: SnackBarType.fail);
      }
      if (regCtr.text.isEmpty) {
        IconSnackBar.show(
            context: context,
            label: "Why did'nt you put your reg number?😑",
            snackBarType: SnackBarType.fail);
      }
    }
  }
}
