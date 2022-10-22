#include <bits/stdc++.h>
 
using namespace std;

class IDRegister {
private:
	vector<string> encodedBinaryStrings;
	string ADD = "0000";
    string SUB = "0001";
    string MUL = "0010";
    string LOAD = "0011";
    string STORE = "0100";
    string BEQ = "0101";
    string BNQ = "0110";
	string STALL = "11111111111111111111";

public:
	void pushNewString(string str) {
		encodedBinaryStrings.push_back(str);
	}

	void insertingStalls() {
		for (int i = 0; i < encodedBinaryStrings.size(); i++) {
			if (encodedBinaryStrings[i].substr(0, 4) == BNQ || encodedBinaryStrings[i].substr(0, 4) == BEQ) {
				auto it = encodedBinaryStrings.begin() + i + 1;
				encodedBinaryStrings.insert(it, 3, STALL);
				i += 3;
			}else if(encodedBinaryStrings[i].substr(0, 4) == LOAD || encodedBinaryStrings[i].substr(0, 4) == ADD || encodedBinaryStrings[i].substr(0, 4) == SUB || encodedBinaryStrings[i].substr(0, 4) == MUL) {
				for (int j = i + 1; j < encodedBinaryStrings.size() && j <= i + 5; j++) {
					if ((encodedBinaryStrings[j].substr(0,4) == ADD || encodedBinaryStrings[j].substr(0, 4) == SUB || encodedBinaryStrings[j].substr(0, 4) == MUL) && (encodedBinaryStrings[i].substr(4, 4) == encodedBinaryStrings[j].substr(8,4) || encodedBinaryStrings[i].substr(4, 4) == encodedBinaryStrings[j].substr(12,4))) {
						auto it = encodedBinaryStrings.begin() + j;
						encodedBinaryStrings.insert(it, 5 - j + i, STALL);
						break;
					}else if (encodedBinaryStrings[j].substr(0, 4) == STORE && encodedBinaryStrings[i].substr(4,4) == encodedBinaryStrings[j].substr(4, 4)) {
						auto it = encodedBinaryStrings.begin() + j;
						encodedBinaryStrings.insert(it, 5 - j + i, STALL);
						break;
					}else if ((encodedBinaryStrings[j].substr(0, 4) == BEQ || encodedBinaryStrings[j].substr(0, 4) == BNQ) && (encodedBinaryStrings[i].substr(4,4) == encodedBinaryStrings[j].substr(4,4) || encodedBinaryStrings[i].substr(4,4) == encodedBinaryStrings[j].substr(8,4))) {
						auto it = encodedBinaryStrings.begin() + j;
						encodedBinaryStrings.insert(it, 5 - j + i, STALL);
						break;
					}
				}
			}
		}
	}

	vector<string> getEncodedBinaryStrings() {
		return this ->encodedBinaryStrings;
	}
};

IDRegister entireEncodedMachineCode = IDRegister();

class EncodeUnit {
private:
	string encodedBinaryString;

	vector<string> parseInstruction(string instruction) {
		string tmp; //to temporarily store elements
		stringstream ss(instruction);
		vector<string> words;
		while(getline(ss, tmp, ' ')){
		    words.push_back(tmp);
		}
		return words;
	}

	string convertingToBinaryString(string letter) {
		int x = letter[0] - 65;
		return bitset<4>(x).to_string();
	}

	string convertingToBinaryString(int x) {
		return bitset<4>(x).to_string();	
	}

	string convertingToBinaryString8Bit(int x) {
		return bitset<8>(x).to_string();	
	}

	string ADD = "0000";
    string SUB = "0001";
    string MUL = "0010";
    string LOAD = "0011";
    string STORE = "0100";
    string BEQ = "0101";
    string BNQ = "0110";

	string encodeInstruction(vector<string> words) {
		string str = "";
		if (words[0] == "lw") {
			str += LOAD;
			str += convertingToBinaryString(words[1]);
			str += convertingToBinaryString(stoi(words[2]));
			str += "0000";
			str += "0000";
		}else if (words[0] == "sw") {
			str += STORE;
			str += convertingToBinaryString(words[1]);
			str += convertingToBinaryString(stoi(words[2]));
			str += "0000";
			str += "0000";
		}else if (words[0] == "add") {
			str += ADD;
			for (int i = 1; i <= 3; i++) {
				str += convertingToBinaryString(words[i]);
			}
			str += "0000";
		}else if (words[0] == "sub") {
			str += SUB;
			for (int i = 1; i <= 3; i++) {
				str += convertingToBinaryString(words[i]);
			}
			str += "0000";
		}else if (words[0] == "mul") {
			str += MUL;
			for (int i = 1; i <= 3; i++) {
				str += convertingToBinaryString(words[i]);
			}
			str += "0000";
		}else if (words[0] == "beq") {
			str += BEQ;
			for (int i = 1; i < 3; i++) {
				str += convertingToBinaryString(words[i]);
			}
			str += convertingToBinaryString8Bit(stoi(words[3]));
		}else if (words[0] == "bnq") {
			str += BNQ;
			for (int i = 1; i < 3; i++) {
				str += convertingToBinaryString(words[i]);
			}
			str += convertingToBinaryString8Bit(stoi(words[3]));
		}else {
			cout << "Syntax Error" << endl;
			//error Handling code to be written here using try and catch statements;
		}
		return str;
	}

public:
	EncodeUnit(string instruction) {
		entireEncodedMachineCode.pushNewString(encodeInstruction(parseInstruction(instruction)));
	}
};

int binaryToDecimal(string n) {
    string num = n;
    int dec_value = 0;
    int base = 1;
    int len = num.length();
    for (int i = len - 1; i >= 0; i--) {
        if (num[i] == '1') {
            dec_value += base;
        }
        base = base * 2;
    }
    return dec_value;
}

string convertingToBinaryString8Bit(int x) {
	return bitset<8>(x).to_string();	
}

int main() {
	fstream fopen;
	fopen.open("InstructionsInMachineCode.txt", ios::out | ios::in);
	int n;
	cin >> n;
	string STALL = "11111111111111111111";
	string BEQ = "0101";
    string BNQ = "0110";
	string blankInstruction;
	getline(cin, blankInstruction);
	for (int i = 0; i < n; i++) {
		string instruction;
		getline(cin, instruction);
		EncodeUnit temp = EncodeUnit(instruction);
	}
	vector<string> machineCodeWithoutStalls = entireEncodedMachineCode.getEncodedBinaryStrings();
	entireEncodedMachineCode.insertingStalls();
	vector<string> machineCodeWithStalls = entireEncodedMachineCode.getEncodedBinaryStrings();
	vector<int> numberOfStallsBeforeEveryInstruction;
	for (int i = 0; i < machineCodeWithoutStalls.size(); i++) {
		int count = 0;
		auto it = find(machineCodeWithStalls.begin(), machineCodeWithStalls.end(), machineCodeWithoutStalls[i]);
		for (auto itr = machineCodeWithStalls.begin(); itr != it; itr++) {
			if (*itr == STALL) {
				count++;
			}
		}
		numberOfStallsBeforeEveryInstruction.push_back(count);
	}
	for (int i = 0; i < machineCodeWithStalls.size(); i++) {
		if (machineCodeWithStalls[i].substr(0,4) == BNQ || machineCodeWithStalls[i].substr(0,4) == BEQ) {
			int effectiveLineNumber = binaryToDecimal(machineCodeWithStalls[i].substr(12, 8));
			effectiveLineNumber += numberOfStallsBeforeEveryInstruction[effectiveLineNumber - 1];
			effectiveLineNumber--;
			string s = machineCodeWithStalls[i].substr(0, 12);
			s += convertingToBinaryString8Bit(effectiveLineNumber);
			machineCodeWithStalls[i] = s;
		}
	}
	string HALT = "11100000000000000000";
	machineCodeWithStalls.push_back(HALT);
	
	for (int i = 0; i < machineCodeWithStalls.size(); i++) {
		// cout << machineCodeWithStalls[i] << endl;
		fopen << machineCodeWithStalls[i] << endl;
	}
	fopen.close();
}

// INPUT Fibonacci
// 13
// lw C 6
// lw A 1
// lw B 2
// lw G 2
// lw H 1
// lw D 1
// beq C A 13
// add D H A
// add A H B
// add B D A
// sub C C G
// bnq C H 8
// sw A 10

// INPUT Factorial
// 10
// lw A 1
// lw E 2
// lw B 2
// lw D 1
// lw C 5
// beq A C 10
// add D D E
// mul B B D
// bnq C D 7
// sw B 10



         