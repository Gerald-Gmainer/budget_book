import { Profile } from "../models/profile.interface";

export interface ProfileState {
  profile: Profile | null;
  loading: boolean;
  error: Error | null;
}

export const initialState: ProfileState = {
  profile: null,
  loading: true,
  error: null,
};
