import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/screens/employer_regisration/cubit/employer_registration_cubit.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/address_info/view/address_info_page.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/personal_info/view/personal_info_page.dart';
import 'package:mobile_app/screens/employer_regisration/widgets/terms_and_condition/view/termsandcondition_screen.dart';

class EmployerStepper extends StatelessWidget {
  const EmployerStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployerRegistrationCubit, EmployerRegisrationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                EasyStepper(
                  direction: Axis.horizontal,
                  enableStepTapping: true,
                  activeStep: state.activeStepperIndex,
                  onStepReached: (index) {
                    // context.read<EmployerRegistrationCubit>().stepTapped(index);
                  },
                  steps: const [
                    EasyStep(icon: Icon(Icons.ondemand_video)),
                    EasyStep(icon: Icon(Icons.ondemand_video)),
                    EasyStep(icon: Icon(Icons.ondemand_video)),
                  ],
                ),
                state.activeStepperIndex == 0
                    ? const PersonalInfoScreen()
                    : state.activeStepperIndex == 1
                        ? const AddressInfoScreen()
                        : const TermsAndConditionScreen()
              ],
            ),
          ),
        );
      },
    );
  }
}



  
  
        // return Theme(
        //   data: ThemeData(
        //     // canvasColor: Colors.yellow,
        //     canvasColor: Colors.transparent,
        //     splashFactory: NoSplash.splashFactory,

        //     colorScheme: Theme.of(context).colorScheme.copyWith(
        //           primary: Colors.green,
        //           background: Colors.red,
        //           secondary: Colors.green,
        //         ),
        //   ),
        //   child: Stepper(
        //     type: StepperType.horizontal,
        //     currentStep: state.activeStepperIndex,
        //     onStepTapped: context.read<EmployerRegistrationCubit>().stepTapped,
        //     elevation: 0,
        //     controlsBuilder: (context, controlDetails) {
        //       return const SizedBox.shrink();
        //     },
        //     stepIconBuilder: (stepIndex, stepState) {
        //       switch (stepIndex) {
        //         case 0:
        //           return const Icon(
        //             Icons.person,
        //             color: Colors.white,
        //           );
        //         case 1:
        //           return const Center(
        //             child: Icon(
        //               Icons.telegram,
        //               color: Colors.white,
        //             ),
        //           );
        //         case 2:
        //           return const Center(
        //             child: Icon(
        //               Icons.car_crash,
        //               color: Colors.white,
        //             ),
        //           );
        //       }
        //       return null;
        //     },
        //     steps: [
        //       Step(
        //         title: const Text(''),
        //         content: const PersonalInfoScreen(),
        //         isActive: state.activeStepperIndex >= 0,
        //         state: state.activeStepperIndex >= 0
        //             ? StepState.complete
        //             : StepState.disabled,
        //       ),
        //       Step(
        //         title: const Text(""),
        //         content: const AddressInfoScreen(),
        //         isActive: state.activeStepperIndex >= 1,
        //         state: state.activeStepperIndex >= 1
        //             ? StepState.complete
        //             : StepState.disabled,
        //       ),
        //       Step(
        //         title: const Text(''),
        //         content: const TermsAndConditionScreen(),
        //         isActive: state.activeStepperIndex >= 2,
        //         state: state.activeStepperIndex >= 2
        //             ? StepState.complete
        //             : StepState.disabled,
        //       ),
        //     ],
        //   ),
        // );
    