import 'package:appwrite/appwrite.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'app_write_client.dart';

final appwriteAccountProvider = Account(appWriteClient);

final supabase = Supabase.instance.client;

