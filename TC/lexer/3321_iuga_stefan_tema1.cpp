// sgr 3321, Iuga Stefan, Tema 1
#include <algorithm>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <vector>

using namespace std;

struct Token {
	string tip;
	string continut;
	int pozitieIdentificator;

	Token()
	{
		tip = "";
		continut = "";
		pozitieIdentificator = -1;
	}
	void print(const vector<string> *identificatori)
	{
		if (pozitieIdentificator >= 0) {
			cout << setw(15) << setfill(' ') << tip << ": "
			     << identificatori->at(pozitieIdentificator)
			     << endl;
		} else {
			cout << setw(15) << setfill(' ') << tip << ": "
			     << continut << endl;
		}
	}
};

class Lexer {
	ifstream stream;
	char peek;
	int linie;
	vector<string> keywords;
	vector<string> *identificatori;

	void skipWhiteSpace()
	{
		while (!eof() &&
		       (peek == ' ' || peek == '\t' || peek == '\n')) {
			if (peek == '\n') {
				linie++;
			}
			stream >> peek;
		}
	}

	Token handleNumber()
	{
		Token result = Token();
		result.tip = "intreg";
		string numar;
		numar += peek;
		stream >> peek;
		while (peek >= '0' && peek <= '9' && !eof()) {
			numar += peek;
			stream >> peek;
		}
		if (peek == '.') {
			result.tip = "float";
			numar += peek;
			stream >> peek;
			if (peek >= '0' && peek <= '9' && !eof()) {
				do {
					numar += peek;
					stream >> peek;
				} while (peek >= '0' && peek <= '9' && !eof());
			} else {
				return handleError();
			}
		}
		if (peek == 'e') {
			result.tip = "float";
			numar += peek;
			stream >> peek;
			if (peek == '-' || peek == '+') {
				numar += peek;
				stream >> peek;
			}
			if (peek >= '0' && peek <= '9' && !eof()) {
				do {
					numar += peek;
					stream >> peek;
				} while (peek >= '0' && peek <= '9' && !eof());
			} else {
				return handleError();
			}
		}
		result.continut = numar;
		return result;
	}

	Token handleString()
	{
		Token result = Token();
		string basicString;
		do {
			if (peek == '\\') {
				stream >> peek;
				if (peek == '\n') {
					linie++;
					stream >> peek;
					continue;
				}
				basicString += peek;
				continue;
			}
			if (peek == '\n') {
				return handleError();
			}
			basicString += peek;
			stream >> peek;
		} while (peek != '"' && !eof());
		if (eof()) {
			return handleError();
		}
		result.tip = "string";
		result.continut = basicString + "\"";
		peek = ' ';
		return result;
	}

	Token handleChar()
	{
		Token result = Token();
		string basicChar;
		do {
			if (peek == '\n')
				return handleError();
			basicChar += peek;
			stream >> peek;
		} while (peek != '\'' && !eof());
		if (eof())
			return handleError();
		result.tip = "char";
		result.continut = basicChar + "'";
		peek = ' ';
		return result;
	}

	Token handleIdentificator()
	{
		string cuvant;
		Token result = Token();
		result.tip = "identificator";
		do {
			cuvant += peek;
			stream >> peek;
			if (stream.eof())
				break;
		} while ((peek >= 'A' && peek <= 'Z') ||
			 (peek >= 'a' && peek <= 'z') ||
			 (peek >= '0' && peek <= '9') || peek == '_');
		if (find(keywords.begin(), keywords.end(), cuvant) !=
		    keywords.end())
			result.tip = "keyword";

		if (!identificatori->empty())
			for (int i = 0; i < identificatori->size(); i++) {
				if (identificatori->at(i) == cuvant) {
					result.pozitieIdentificator = i;
					return result;
				}
			}
		identificatori->push_back(cuvant);

		result.pozitieIdentificator = (int)identificatori->size() - 1;
		return result;
	}

	int skipComment()
	{
		string end = "  ";
		while (!eof() && end != "*/") {
			if (peek == '\n') {
				linie++;
			}
			stream >> peek;
			end[0] = end[1];
			end[1] = peek;
		}
		if (eof())
			return 1;
		return 0;
	}

	Token handleSimbol()
	{
		Token result = Token();
		switch (peek) {
		case '/': {
			char peek2;
			stream >> peek2;
			if (peek2 == '*') {
				if (skipComment() == 1) {
					return handleError();
				}
				peek = ' ';
				return getToken();
			} else {
				result.tip = "operator";
				if (peek2 == '=') {
					result.continut = "/=";
					peek = ' ';
				} else {
					result.continut = "/";
					peek = peek2;
				}
			}
			break;
		}
		case ';':
		case ',': {
			result.tip = "delimitator";
			result.continut += peek;
			peek = ' ';
			break;
		}
		case '(':
		case ')':
		case '[':
		case ']':
		case '{':
		case '}': {
			result.tip = "paranteza";
			result.continut += peek;
			peek = ' ';
			break;
		}
		case '&':
		case '|':
		case '<':
		case '>':
		case '-':
		case '+': {
			char peek2;
			stream >> peek2;
			if (!eof()) {
				if (peek == '-' && peek2 == '>') {
					result.tip = "operator";
					result.continut += peek;
					result.continut += peek2;
					peek = ' ';
					break;
				}
				if (peek2 == peek || peek2 == '=') {
					result.tip = "operator";
					result.continut += peek;
					result.continut += peek2;
					stream >> peek2;
					if (peek2 == '=') {
						result.continut += peek2;
						peek = ' ';

					} else {
						peek = peek2;
					}
				} else {
					result.tip = "operator";
					result.continut += peek;
					peek = peek2;
				}
			} else {
				result.tip = "operator";
				result.continut += peek;
				peek = ' ';
			}
			break;
		}
		case '*':
		case '=':
		case '%':
		case '^':
		case '!':
		case '~': {
			char peek2;
			stream >> peek2;
			if (!eof()) {
				if (peek2 == '=') {
					result.tip = "operator";
					result.continut += peek;
					result.continut += peek2;
					peek = ' ';
				} else {
					result.tip = "operator";
					result.continut += peek;
					peek = peek2;
				}
			} else {
				result.tip = "operator";
				result.continut += peek;
				peek = ' ';
			}
			break;
		}
		case '.': {
			result.tip = "operator";
			result.continut += peek;
			peek = ' ';
			break;
		}
		default:
			return handleError();
		}
		return result;
	}

	Token handleError()
	{
		Token result = Token();
		ostringstream errLine;
		errLine << linie;
		string tip;
		if (eof()) {
			tip = "EOF";
		} else {
			tip = "eroare";
		}
		result.tip = tip;
		result.continut = "linia " + errLine.str();
		if (peek != '\n')
			peek = ' ';
		return result;
	}

    public:
	explicit Lexer(const char *fileName)
	{
		stream.open(fileName);
		stream >> noskipws;
		peek = ' ';
		linie = 1;
		identificatori = new vector<string>;

		keywords.reserve(32);
		keywords.push_back("auto");
		keywords.push_back("break");
		keywords.push_back("case");
		keywords.push_back("char");
		keywords.push_back("const");
		keywords.push_back("continue");
		keywords.push_back("default");
		keywords.push_back("do");
		keywords.push_back("double");
		keywords.push_back("else");
		keywords.push_back("enum");
		keywords.push_back("extern");
		keywords.push_back("float");
		keywords.push_back("for");
		keywords.push_back("goto");
		keywords.push_back("if");
		keywords.push_back("int");
		keywords.push_back("long");
		keywords.push_back("register");
		keywords.push_back("return");
		keywords.push_back("short");
		keywords.push_back("signed");
		keywords.push_back("sizeof");
		keywords.push_back("static");
		keywords.push_back("struct");
		keywords.push_back("switch");
		keywords.push_back("typedef");
		keywords.push_back("union");
		keywords.push_back("unsigned");
		keywords.push_back("void");
		keywords.push_back("volatile");
		keywords.push_back("while");
	}
	~Lexer()
	{
		if (stream.is_open())
			stream.close();
		delete identificatori;
	}
	const vector<string> *getIdentificatori()
	{
		return identificatori;
	}

	bool eof()
	{
		return stream.eof();
	}
	Token getToken()
	{
		Token result = Token();

		skipWhiteSpace();

		if (eof()) {
			return handleError();
		}

		if (peek >= '0' && peek <= '9') {
			return handleNumber();
		}

		if (peek == '"') {
			return handleString();
		}

		if (peek == '\'') {
			return handleChar();
		}

		if ((peek >= 'A' && peek <= 'Z') ||
		    (peek >= 'a' && peek <= 'z') || peek == '_') {
			return handleIdentificator();
		}

		return handleSimbol();
	}
};

int main(int argc, char *argv[])
{
	if (argc > 2) {
		cout << "Introdu doar un fisier pentru scanare\n";
		return 1;
	}
	if (argc == 1) {
		cout << "Introdu un fisier pentru scanare\n";
		return 1;
	}
	Lexer *lexer = new Lexer(argv[1]);
	while (!lexer->eof()) {
		lexer->getToken().print(lexer->getIdentificatori());
	}
	delete (lexer);
	return 0;
}
