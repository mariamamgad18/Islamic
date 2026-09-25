import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/DI/injection.dart';
import 'cubit/nearby_mosques_states.dart';
import 'cubit/nearby_mosques_view_model.dart';

class NearbyMosquesScreen extends StatelessWidget {
  const NearbyMosquesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      getIt<NearbyMosquesViewModel>()
        ..getNearbyMosques(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nearby Mosques'),
        ),
        body: BlocBuilder<
            NearbyMosquesViewModel,
            NearbyMosquesState>(
          builder: (context, state) {
            // =========================
            // Loading
            // =========================

            if (state is NearbyMosquesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // =========================
            // Error
            // =========================

            if (state is NearbyMosquesErrorState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 50,
                      ),

                      const SizedBox(height: 16),

                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 16),

                      ElevatedButton(
                        onPressed: () {
                          NearbyMosquesViewModel
                              .get(context)
                              .getNearbyMosques();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // =========================
            // Success
            // =========================

            if (state is NearbyMosquesSuccessState) {
              if (state.mosques.isEmpty) {
                return const Center(
                  child: Text(
                    'No mosques found nearby',
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.mosques.length,
                itemBuilder: (context, index) {
                  final mosque = state.mosques[index];

                  return Card(
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(
                          Icons.mosque,
                        ),
                      ),
                      title: Text(
                        mosque.name,
                      ),
                      subtitle: Text(
                        mosque.address,
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}